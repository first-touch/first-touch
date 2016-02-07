class AuthenticatedControllerBase < ApplicationController
  before_filter :authenticate_user!
end
