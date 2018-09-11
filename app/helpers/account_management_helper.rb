module AccountManagementHelper
  def confirm_account_path(confirmation_token)
    "#{ActionMailer::Base.default_url_options[:host]}/users/confirmation?confirmation_token=#{confirmation_token}"
  end
end
