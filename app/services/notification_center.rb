module NotificationCenter
  # NOTE: Your messenger classes must implement def notify(ref, data, user)
  NOTIFIERS = [
    {
      template: AppNotificationTemplate,
      messenger: SystemAppNotificationService
    },
    { template: EmailTemplate, messenger: SystemMailer }
  ].freeze

  def self.send_notification(ref, data, user_id)
    NOTIFIERS.each do |notifier|
      message = notifier[:template].find_by_ref ref
      notifier[:messenger].delay.notify(ref, data, user_id) if message
    end
  end
end
