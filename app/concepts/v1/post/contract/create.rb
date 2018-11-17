require 'reform/form/validation/unique_validator'

module V1
  module Post
    module Contract
      class Create < Reform::Form
        property :content
        property :author
        validates :content,
                  :author,
                  presence: true
      end
    end
  end
end
