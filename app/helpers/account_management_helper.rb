module AccountManagementHelper
  def confirm_account_path(confirmation_token)
    "/users/confirmation?confirmation_token=#{confirmation_token}"
  end
end
