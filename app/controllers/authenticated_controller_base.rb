class AuthenticatedControllerBase < ApplicationController
  before_action :check_auth, :authenticate_user!
end
