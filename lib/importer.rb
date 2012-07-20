module Importer

  # Show select file form. No logic with model
  def import_step_1
    render 'application/import/step_1'
  end

  # Save CSV file to database and select columns to import
  def import_step_2

    # Get encoding from params
    case params[:encoding]
      when 'windows-1251' then encoding = 'windows-1251'
      when 'utf-8' then encoding = 'utf-8'
      else encoding = 'utf-8'
    end

    # Get column separator from params
    case params[:col_sep]
      when 'semicolon' then col_sep = ';'
      when 'comma' then col_sep = ','
      when 'tab' then col_sep = '\t'
      else col_sep = ','
    end

    begin
      ActiveRecord::Base.transaction do

        @import = Import.new(self.model)

        f = File.open(params[:file].tempfile, "rb:#{encoding}:utf-8")
        # Maybe once I will use this converter to escape quotes
        # converters: lambda do |str| str = str.gsub(/"/,'""') end
        CSV.parse(f, {headers: true, col_sep: col_sep}) do |row|
          
          # Skip blank row
          next if row.to_s.parse_csv.join.blank?

          # Create new ImportRow object
          import_row = @import.import_table.import_rows.create
          
          # Get the attributes from CSV-row and write them to import-row
          row.each do |cell|
            
            header = cell[0].to_s
            data = cell[1].to_s

            import_row.import_cells.create(
              header: header,
              data: data
            )
          end
        end
      end

      render 'application/import/step_2'

    rescue ActiveRecord::RecordInvalid
      flash[:error] = t('import.errors.general.error')
      redirect_to step(1)
      return
    rescue ArgumentError
      flash[:error] = t('import.errors.general.encoding')
      redirect_to step(1)
      return      
    rescue NoMethodError, CSV::MalformedCSVError
      flash[:error] = t('import.errors.general.incorrect_params')
      redirect_to step(1)
      return
    end
  end

  # Try to perform the import and render right page
  def import_step_3
    @import = Import.new(self.model, params[:import_table], columns: params[:columns])
   
    if @import.save?
      redirect_to eval("#{params[:controller]}_path"), notice: t('import.complete')
    else
      flash.now[:error] = t('import.errors.general.error')
      render 'application/import/step_2'
    end
  end

  def model
    params[:controller].classify.constantize
  end

  def step(n)
    eval("#{params[:controller]}_import_step_#{n.to_s}_path")
  end
end