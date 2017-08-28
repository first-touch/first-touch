class AppNotificationTemplate < ActiveRecord::Base
  TEMPLATED_FIELDS = %w[title content].freeze

  include Notification
end
