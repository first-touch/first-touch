class SystemMailer < ApplicationMailer
  # gives access to all helpers defined within `application_helper`.
  helper :account_management
  default template_path: 'system_mailer'

  def notify(template_reference, data, user_id)
    user = find_user user_id

    email_template = find_email_template template_reference
    return if email_template.nil?

    send(email_template, user: user, params: data)
  end

  def find_user(user_id)
    User.find_by(id: user_id)
  end

  def find_email_template(reference)
    return nil if reference.blank?

    mailer_method = reference.underscore.to_sym
    return mailer_method if respond_to?(mailer_method, true)
  end

  private

  def connection_requested(user:, params:)
    @user = user
    @requestor = find_user(params[:requestor_id])
    @connection_id = params[:connection_id]
    mail(to: @user.email,
         subject: "[FirstTouch] #{@requestor.display_name} invited you to connect",
         template_name: 'connection_requested')
  end
end
