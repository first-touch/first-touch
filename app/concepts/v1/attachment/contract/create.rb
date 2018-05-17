module V1
  module Attachment
    module Contract
      class Create < Reform::Form
        property :url
        property :filename
        property :report
      end
    end
  end
end
