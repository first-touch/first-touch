config = YAML.safe_load(
  ERB.new(
    File.read(
      Rails.root.join('config', 'paperclip.yml')
    )
  ).result
)[Rails.env]

config&.each do |k, v|
  Paperclip::Attachment.default_options[k.to_sym] = v
end
