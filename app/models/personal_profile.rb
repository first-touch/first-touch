class PersonalProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  delegate :update_search_string, to: :user, allow_nil: true

  before_save :update_search_string, if: -> { name_changed? }

  def avatar_url
    if avatar.attached?
      service_url(avatar)
    else
      FirstTouch::AVATAR
    end
  end

  private

  def name_changed?
    first_name_changed? || middle_name_changed? || last_name_changed?
  end
end
