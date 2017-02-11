class PersonalProfile < ApplicationRecord
  belongs_to :user

  delegate :update_search_string, to: :user, allow_nil: true

  before_save :update_search_string, if: -> { first_name_changed? || middle_name_changed? || last_name_changed? }
end
