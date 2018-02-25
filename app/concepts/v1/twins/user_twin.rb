# FIXME: This should probably live under user
module V1
  module Twins
    class UserTwin < Disposable::Twin
      property :id
      property :roles
      property :personal_profile
      property :following, virtual: true
      property :connection_status, virtual: true
    end
  end
end
