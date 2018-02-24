require 'reform/form/validation/unique_validator'

module V1
  module Note
    module Contract
      class Create < Reform::Form
        property :content
        property :user
        property :name
        property :tag_list
        property :image, populate_if_empty: ->(*) { ::Image.new } do
          property :file
        end

        validates :user, :name, presence: true
      end
    end
  end
end