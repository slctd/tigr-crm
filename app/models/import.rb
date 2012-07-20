class Import
  include ActiveModel::Validations
  
  attr_accessor :import_columns, :import_table, :columns, :rules, :object

  def valid?
    check_rules
    return false if self.errors[:base].any?
    return true
  end

  def save?
    return false unless self.valid?

    begin
      ActiveRecord::Base.transaction do
        self.import_table.import_rows.each do |row|
          object = self.object.new

          self.import_columns.each do |column|
            cell = cell_number(column.to_s)

            # Find the value in the CSV cell
            value = nil
            value = row.import_cells.find_by_number(cell).data unless cell.nil?


            # If there are rules, use them
            if self.rules[column.to_sym].present?

              # If there is a proc, call it
              if self.rules[column.to_sym][:proc].present?
                value = self.rules[column.to_sym][:proc].call(value) unless value.nil?
              end

              # If there is default value and cell is empty, set it
              if self.rules[column.to_sym][:default].present?
                value = self.rules[column.to_sym][:default] if value.nil?
              end
            end

            # Set the attribute of object
            object.send("#{column.to_s}=", value) unless value.nil?
          end

          object.save!
        end
        self.import_table.destroy
      end
    rescue
      return false
    end

    return true
  end

  private
    def initialize(object, import_table = nil, attributes = {})
      self.object = object
      self.rules = object.import_rules
      self.import_columns = object.import_columns
      
      unless import_table.nil?
        self.import_table = ImportTable.find(import_table)
      else
        self.import_table = ImportTable.create
      end

      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    
    def persisted?
      false
    end

    def check_rules
      # Uniqueness
      column_names = []
      self.columns.each do |key, value|
        column_names << value
      end
      self.errors[:base] << I18n.t('import.errors.general.unique') if column_names.uniq.length != column_names.length

      # Other rules
      self.rules.each do |key, value|
        if value[:required] == true
          err = true
          self.columns.each do |col_key, col_value|
            err = false if col_value == key.to_s
          end
          self.errors[:base] << I18n.t("import.errors.#{self.object.name.downcase}.no_#{key}") if err
        end
      end
    end

    def cell_number(header)
      self.columns.each do |col_key, col_value|
        return col_key.to_i if col_value == header
      end
      return nil
    end
end