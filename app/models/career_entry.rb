class CareerEntry < ApplicationRecord
  belongs_to :user
  belongs_to :club

  validates_presence_of :start_date
  validate :start_date_before_end_date, if: -> { start_date.present? && end_date.present? }

  private

  def start_date_before_end_date
    unless start_date < end_date
      errors[:start_date] = "has to be earlier than end date"
    end
  end

end
