module V1
  module Order
    module Contract
      class SendMoney < Reform::Form
        property :report

        validates :report, presence: true
      end
    end
  end
end
