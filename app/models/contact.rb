class Contact < ActiveRecord::Base

  # Attributes to import
  def self.import_columns
    [:description, :contact_type]
  end

  # Import rules
  def self.import_rules
    {
      polymorphic: { 
        :company => Proc.new { |row, numbers| row.import_cells.find_by_number(numbers['name'].to_i).data != "" and 
                                              row.import_cells.find_by_number(numbers['firstname'].to_i).data =="" and
                                              row.import_cells.find_by_number(numbers['lastname'].to_i).data == "" },
        
        :person => Proc.new { |row, numbers|  row.import_cells.find_by_number(numbers['firstname'].to_i).data != "" and
                                              row.import_cells.find_by_number(numbers['lastname'].to_i).data != "" }
      },

      contact_type: {
        proc: Proc.new { |value|
          contact_type = nil
          ContactType.all.each do |type|
            if I18n.t("types.contact.#{type.name}") == value
              contact_type = type
              break
            end
          end
          contact_type
        },
        default: nil
      }
    }
  end

  def self.to_csv
    columns = [:firstname, :lastname, :name, :job,:contact_type, :description]
    
    CSV.generate do |csv|
      csv << columns.map { |column| I18n.t("activerecord.attributes.company.#{column.to_s}", default: I18n.t("activerecord.attributes.person.#{column.to_s}"))}

      contacts = Company.all + Person.all

      contacts.each do |contact|
        fields = []
        
        if contact.is_a?(Person)
          fields << contact.firstname
          fields << contact.lastname
          contact.company.present? ? fields << contact.company.name : fields << ""
          fields << contact.job
        else
          fields << ""
          fields << ""
          fields << contact.name
          fields << ""
        end

        contact.contact_type.present? ? fields << I18n.t("types.contact.#{contact.contact_type.name}") : fields << ""

        fields << contact.description || ""

        csv << fields
      end
    end
  end
end