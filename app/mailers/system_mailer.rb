class SystemMailer < ActionMailer::Base
  def notify(template_reference, data, user_id)
    user = find_user user_id
    locale = find_locale_for_template user

    email_template = find_email_template template_reference, locale
    return if email_template.blank?

    send_mail user.email, email_template, data
  end

  def send_mail(to, email_template, data)
    reply_to  = email_template.reply_to || OPL::Application.config.DEFAULT_MAIL_FROM
    from      = email_template.robot || OPL::Application.config.DEFAULT_MAIL_FROM
    subject   = email_template.filled_subject data
    body      = email_template.filled_body data

    mail from: from, to: to, reply_to: reply_to, subject: subject do |format|
      format.text { body }
      format.html { body }
    end
  end

  def find_user(user_id)
    User.find user_id
  end

  def find_locale_for_template(user)
    user.preferred_locale || OPL::Application.config.DEFAULT_LOCALE
  end

  def find_email_template(reference, locale)
    templates = EmailTemplate.where(ref: reference)
    locale_template = templates.find { |t| t.locale == locale }
    return locale_template if locale_template.present?
    return templates.first if templates.present?
  end
end
