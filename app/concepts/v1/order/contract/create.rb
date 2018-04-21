module V1
  module Order
    module Contract
      class Create < Reform::Form
        property :price
        property :status
        property :user
        property :report
        property :customer_id

        validates :price,
        :status,
        :user,
        :report,
        :customer_id,
        presence: true

        validate :status_is_registerable
        validates_uniqueness_of :customer_id, scope: [:report, :customer_id]

        def status_is_registerable
          current_status = model.status
          return if FirstTouch::REGISTERABLE_ORDER_STATUS.include? current_status
          errors.add(:status, I18n.t('order.invalid_status'))
        end

      end
    end
  end
end
