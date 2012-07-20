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

          # Rules set is default
          rules_set = self.rules
          import_columns_set = self.import_columns
          object = nil
          # Detect type of object
          if self.rules[:polymorphic].present?
            self.rules[:polymorphic].each do |subclass, condition|
              if condition.call(row, hash_revert(self.columns))
                rules_set = rules_set.merge(subclass.to_s.camelize.constantize.import_rules)
                import_columns_set += subclass.to_s.camelize.constantize.import_columns
                object = subclass.to_s.camelize.constantize.new
                break
              end
            end
          else
            object = self.object.new
          end

          import_columns_set.each do |column|
            # Transform column. Is's required because of columns like
            # :name => :alias
            column = column.to_a[0][0].to_s.to_sym if column.is_a?(Hash)

            cell = cell_number(column.to_s)

            # Find the value in the CSV cell
            value = nil
            value = row.import_cells.find_by_number(cell).data unless cell.nil?

            # What attribute to set
            attribute = column.to_s

            # If there are rules, use them
            if rules_set[column.to_sym].present?

              # If there is a proc, call it
              if rules_set[column.to_sym][:proc].present?
                value = rules_set[column.to_sym][:proc].call(value) unless value.nil?
              end

              # If there is default value and cell is empty, set it
              if rules_set[column.to_sym][:default].present?
                value = rules_set[column.to_sym][:default] if value.nil?
              end

              # If there is an alias to another column
              if rules_set[column.to_sym][:alias_to].present?
                attribute = rules_set[column.to_sym][:alias_to].to_s
              end
            end

            # Set the attribute of object
            object.send("#{attribute}=", value) unless value.nil?
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

    def hash_revert h
      new_h = Hash.new
      h.each {|key,value|
        if not new_h.has_key?(key) then new_h[value] = key end
      }
      return new_h
    end
end