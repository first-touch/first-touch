module AccountManagementHelper
  def confirm_account_path(confirmation_token)
    "#{ActionMailer::Base.default_url_options[:host]}/users/confirmation?confirmation_token=#{confirmation_token}"
  end

  def reset_password_path(reset_token)
    "#{ActionMailer::Base.default_url_options[:host]}/users/new_password?reset_token=#{reset_token}"
  end

  def accept_invitation(friend_id, invitation_id)
    "#{ActionMailer::Base.default_url_options[:host]}/users/#{friend_id}/profile?accept_invitation=#{invitation_id}"
  end
end
