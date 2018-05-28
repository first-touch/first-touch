class StripeTransaction < ApplicationRecord
  belongs_to :order
end
