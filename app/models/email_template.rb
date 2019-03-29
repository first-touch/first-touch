class EmailTemplate < ApplicationRecord
  TEMPLATED_FIELDS = %w[subject body].freeze

  include Notification
end
