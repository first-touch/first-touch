module V1
  module Attachment
    module Contract
      class Create < Reform::Form
        property :url
        property :filename
        property :report
        property :request_bid
      end
    end
  end
end
