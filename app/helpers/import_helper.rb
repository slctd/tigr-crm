module ImportHelper

  def import_options_for_select(import, header, n)
    options = []

    # Add don't import option
    options << [t('import.dont_import'), "dont_import"]

    # Add general columns
    import.import_columns.map do |col| 
      options << [t("activerecord.attributes.#{import.object.to_s.downcase}.#{col.to_s}"), col.to_s]
    end

    # Add columns for polymorphic classes
    if import.rules[:polymorphic].present?
      import.rules[:polymorphic].each do |subclass, proc|
        subclass.to_s.camelize.constantize.import_columns.map do |col|
          options << [t("activerecord.attributes.#{subclass.to_s}.#{col.to_s}"), col.to_s] unless col.is_a?(Hash)
        end
      end
    end

    options_for_select(options, default_value(import, header, n))
  end

  def step(n)
    eval("#{params[:controller]}_import_step_#{n.to_s}_path")
  end

  private
    def default_value(import, header, n)
      if params["columns"].present?
        params["columns"]["#{n}"]
      else

        # If object is polymorphic
        if import.rules[:polymorphic].present?
          import.rules[:polymorphic].each do |subclass, proc|
            subclass.to_s.camelize.constantize.import_columns.each do |col|
              return col.to_s if header == t("activerecord.attributes.#{subclass.to_s}.#{col.to_s}")
            end
          end
        end

        import.import_columns.each do |col| 
          return col.to_s if header == t("activerecord.attributes.#{import.object.to_s.downcase}.#{col.to_s}")
        end
        
        # If function didn't return anything select "don't import" option
        "dont_import"
      end
    end
end