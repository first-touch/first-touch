module V1
  module Report
    module Contract
      class Create < Reform::Form
        property :user
        property :headline
        property :status
        property :type_report
        property :price
        property :club_id
        property :player_id

        validates :headline, :user, :price,:type_report, presence: true

        validate :type_is_registerable

        def type_is_registerable
          current_type = model.type_report
          return if FirstTouch::REGISTERABLE_REPORT_TYPES.include? current_type
          errors.add(:type_report, I18n.t('report.invalid_type'))
        end
      end
    end
  end
end