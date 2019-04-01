module NotificationCenter
  # NOTE: Your messenger classes must implement def notify(ref, data, user)
  NOTIFIERS = [
    { messenger: SystemAppNotificationService },
    { messenger: SystemMailer }
  ].freeze

  def self.send_notification(ref, data, user_id)
    NOTIFIERS.each do |notifier|
      notifier[:messenger].delay.notify(ref, data, user_id)
    end
  end
end
