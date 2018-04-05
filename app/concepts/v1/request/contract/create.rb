module V1
  module Request
    module Contract
      class Create < Reform::Form
        property :min_price
        property :max_price
        property :meta_data
        property :deadline
        property :type_request
        property :status
        validates :min_price, :status, :meta_data, :deadline, :type_request, presence: true

        validate :type_is_registerable
        validate :status_is_registerable

        def type_is_registerable
          current_type = model.type_request
          return if FirstTouch::REGISTERABLE_REQUEST_TYPES.include? current_type
          errors.add(:type_request, I18n.t('request.invalid_type'))
        end

        def status_is_registerable
          current_status = model.status
          return if FirstTouch::REGISTERABLE_REQUEST_STATUS.include? current_status
          errors.add(:status, I18n.t('request.invalid_status'))
        end

      end
    end
  end
end
