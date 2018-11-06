require 'reform/form/validation/unique_validator'

module V1
  module PersonalProfile
    module Contract
      class Create < Reform::Form
        property :first_name
        property :middle_name
        property :last_name
        property :birthday
        property :nationality_country_code
        property :residence_country_code
        property :place_of_birth
        property :weight
        property :height
        property :preferred_foot
        property :playing_positions
        property :pro_status
        property :biography
        property :avatar

        validates :first_name,
                  :last_name,
                  :birthday,
                  presence: true

        validate :playing_positions_contents

        def playing_positions_contents
          return true if playing_positions.nil?
          return false unless playing_positions_format_valid?
          return false unless all_positions_valid?
          true
        end

        def playing_positions_format_valid?
          return true if playing_positions.is_a?(Array)
          errors.add(
            :playing_positions,
            I18n.t('personal_profile.invalid_playing_positions_format')
          )
          false
        end

        def all_positions_valid?
          invalid_positions = playing_positions.reject do |pos|
            FirstTouch::PLAYING_POSITIONS.include? pos['position']
          end
          return true unless invalid_positions.length.positive?
          errors.add(:playing_positions,
                     I18n.t('personal_profile.invalid_playing_positions',
                            invalid_positions: invalid_positions.join(', ')))
          false
        end
      end
    end
  end
end
