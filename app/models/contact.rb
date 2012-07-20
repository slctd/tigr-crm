class Contact < ActiveRecord::Base

  # Attributes to import
  def self.import_columns
    [:contact_type]
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
end