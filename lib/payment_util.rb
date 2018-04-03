class PaymentUtil
  class << self
    def made_payment(params)
      if params["payment_method"] == 'fake-success'
        {
          status: "completed"
        }
      else
        false
      end
    end
  end
end
