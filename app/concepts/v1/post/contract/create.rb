require 'reform/form/validation/unique_validator'

module V1
  module Post
    module Contract
      class Create < Reform::Form
        property :content
        property :author

        collection :images, populate_if_empty: ::Image do
          property :file
        end

        validates :content,
                  :author,
                  presence: true
      end
    end
  end
end
