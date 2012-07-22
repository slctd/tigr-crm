require 'zip/zipfilesystem'

class OptionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: OptionsController

  def index
    
  end

  def export

    begin

      # Define export path
      export_path = "#{Rails.root}/public/export"

      # Create it if it doesn't exist
      Dir.mkdir(export_path) unless File.directory? export_path

      # Generate random string to secure files from accident access
      random_dir = Digest::SHA1.hexdigest(Time.now.to_s + "random salt 1749 yadf dfhasdiofuna89fad")
      
      # Create such dir
      Dir.mkdir("#{export_path}/#{random_dir}")

      # Generate filename as current datetime
      filename = Time.now.to_s(:number)

      # Write zip file
      Zip::ZipFile.open("#{export_path}/#{random_dir}/#{filename}.zip", Zip::ZipFile::CREATE) do |zipfile|
     
        zipfile.file.open("contacts.csv", "w") do |f| 
          CSV.open(f, "w") do |csv|
            CSV.parse(Contact.to_csv) { |row| csv << row }
          end
        end

        zipfile.file.open("tasks.csv", "w") do |f| 
          CSV.open(f, "w") do |csv|
            CSV.parse(Task.to_csv) { |row| csv << row }
          end
        end

        zipfile.file.open("deals.csv", "w") do |f| 
          CSV.open(f, "w") do |csv|
            CSV.parse(Deal.to_csv) { |row| csv << row }
          end
        end

        zipfile.file.open("events.csv", "w") do |f| 
          CSV.open(f, "w") do |csv|
            CSV.parse(Event.to_csv) { |row| csv << row }
          end
        end
      end

      # Generate link to file
      @file_link = "http://#{request.host}/export/#{random_dir}/#{filename}.zip"
      
      # Right now we will not send emails
      # CrmMailer.export(current_user, file_link).deliver

      # Render view with flash message
      flash.now[:notice] = t('options.export.success')

    rescue
      flash[:error] = t('options.export.failure')
      redirect_to options_path
      return
    end

  end
end