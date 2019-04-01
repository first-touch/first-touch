module SystemAppNotificationService
  def notify(template_reference, data, user_id)
    user = find_user user_id

    template = find_app_notification_template template_reference
    return if template.blank?

    send_notification template, data, user
  end

  def find_user(user_id)
    User.find user_id
  end

  def find_app_notification_template(reference)
    AppNotificationTemplate.find_by(ref: reference)
  end

  def send_notification(template, data, user)
    title = template.filled_title data
    content = template.filled_content data

    new_notification = AppNotification.new
    new_notification.user = user
    new_notification.title = title
    new_notification.content = content
    new_notification.read = false
    new_notification.save
  end
end
