module V1
  module Report
    module Contract
      class Update < Reform::Form
        property :headline
        property :status
        property :price

        validate :status_is_registerable

        def status_is_registerable
          current_status = model.status
          return if FirstTouch::REGISTERABLE_REPORT_STATUS.include? current_status
          errors.add(:status, I18n.t('report.invalid_status'))
        end
      end
    end
  end
end