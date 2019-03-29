module ErbTemplateHelper
  extend ActionView::Helpers::TagHelper
  extend ActionView::Helpers::AssetTagHelper
  extend ActionView::Helpers::NumberHelper

  def self.render(template, data)
    current_binding = binding

    data.each do |key, value|
      current_binding.local_variable_set(key, value)
    end

    ERB.new(template).result(current_binding)
  end

  def self.url_to(anchor)
    "#{ENV['HOSTNAME']}/##{anchor}"
  end
end
