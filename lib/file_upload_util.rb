class FileUploadUtil
  class << self
    def save_file(file,report_id,report_datum_version)
      path = Rails.root.join('public', 'report', report_id,report_datum_version)
      create_folder(path)
      File.open(Rails.root.join('public', 'report', report_id,report_datum_version, file.original_filename),'wb') do |nf|
        nf.write(file.read)
      end
      Rails.root.join('public', 'report', report_id,report_datum_version, file.original_filename)
    end

    def create_folder(dirname)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

  end
end
