module SystemAppNotificationService
  def self.notify(template_reference, data, user_id)
    user = find_user user_id
    locale = find_locale_for_template user

    template = find_app_notification_template template_reference, locale
    return if template.blank?

    send_notification template, data, user
  end

  def self.find_user(user_id)
    User.find user_id
  end

  def self.find_locale_for_template(user)
    user.preferred_locale || OPL::Application.config.DEFAULT_LOCALE
  end

  def self.find_app_notification_template(reference, locale)
    templates = AppNotificationTemplate.where(ref: reference)
    locale_template = templates.find { |t| t.locale == locale }

    return locale_template if locale_template.present?
    return templates.first if templates.present?
  end

  def self.send_notification(template, data, user)
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
