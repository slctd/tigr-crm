module ImportHelper

  def import_options_for_select(import, header, n)
    options_for_select(
      import.import_columns.map { |col| 
        [t("activerecord.attributes.#{import.object.to_s.downcase}.#{col.to_s}"), col.to_s]
      }, 
      default_value(import, header, n)
    )
  end

  def step(n)
    eval("#{params[:controller]}_import_step_#{n.to_s}_path")
  end

  private
    def default_value(import, header, n)
      if params["columns"].present?
        params["columns"]["#{n}"]
      else
        import.import_columns.each do |col| 
          return col.to_s if header == t("activerecord.attributes.#{import.object.to_s.downcase}.#{col.to_s}")
        end
        import.import_columns[0].to_s
      end
    end
end