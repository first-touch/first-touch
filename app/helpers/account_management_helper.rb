module AccountManagementHelper
  def confirm_account_path(confirmation_token)
    "http:\/\/localhost:3001\/users\/confirmation\/?confirmation_token=#{confirmation_token}"
  end
end
