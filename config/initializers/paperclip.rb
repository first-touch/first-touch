config = YAML.load(
  ERB.new(
    File.read(
      Rails.root.join('config', 'paperclip.yml')
    )
  ).result)[Rails.env]

if config
  config.each do |k,v|
    Paperclip::Attachment.default_options[k.to_sym] = v
  end
end
