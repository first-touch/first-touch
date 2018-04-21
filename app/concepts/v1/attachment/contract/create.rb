module V1
  module Attachment
    module Contract
      class Create < Reform::Form
        property :url
        property :filename

      end
    end
  end
end