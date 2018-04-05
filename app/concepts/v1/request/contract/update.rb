module V1
  module Request
    module Contract
      class Update < Reform::Form
        property :min_price
        property :max_price
        property :meta_data
        property :deadline
        property :status

        validate :status_is_registerable

        def status_is_registerable
          current_status = model.status
          return if FirstTouch::REGISTERABLE_REQUEST_STATUS.include? current_status
          errors.add(:status, I18n.t('request.invalid_status'))
        end

      end
    end
  end
end
