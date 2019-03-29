class SystemMailer < ActionMailer::Base
  def notify(template_reference, data, user_id)
    user = find_user user_id

    email_template = find_email_template template_reference
    return if email_template.blank?

    send_mail user.email, email_template, data
  end

  def send_mail(to, email_template, data)
    reply_to  = email_template.reply_to || FirstTouch::Application.config.DEFAULT_MAIL_FROM
    from      = email_template.robot || FirstTouch::Application.config.DEFAULT_MAIL_FROM
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

  def find_email_template(reference)
    templates = EmailTemplate.where(ref: reference)
    return templates.first if templates.present?
  end
end
