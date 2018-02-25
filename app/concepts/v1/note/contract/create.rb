require 'reform/form/validation/unique_validator'

module V1
  module Note
    module Contract
      class Create < Reform::Form
        property :content
        property :user
        property :name
        property :image_url

        validates :user, :name, presence: true
      end
    end
  end
end