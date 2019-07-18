module AccountManagementHelper
  def confirm_account_path(confirmation_token)
    url_base = ActionMailer::Base.default_url_options[:protocol] +
               ActionMailer::Base.default_url_options[:host]

    "#{url_base}/users/confirmation?confirmation_token=#{confirmation_token}"
  end

  def reset_password_path(reset_token)
    url_base = ActionMailer::Base.default_url_options[:protocol] +
               ActionMailer::Base.default_url_options[:host]

    "#{url_base}/users/new_password?reset_token=#{reset_token}"
  end

  def accept_invitation(friend_id, invitation_id)
    url_base = ActionMailer::Base.default_url_options[:protocol] +
               ActionMailer::Base.default_url_options[:host]

    "#{url_base}/users/#{friend_id}/profile?accept_invitation=#{invitation_id}"
  end
end
