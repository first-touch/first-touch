require 'terrapin'

module FileTypeDetector
  def self.mime_type(file_path)
    line = Terrapin::CommandLine.new('file --brief --mime-type', file_path)
    line.run.delete("\n")
  end
end
