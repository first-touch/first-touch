class Statistic < ApplicationRecord
  PROFILE_VIEW = 'profile_view'
  enum stat_type: {
    profile_view: 0
  }
end
