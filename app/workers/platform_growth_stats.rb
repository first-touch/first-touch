class PlatformGrowthStats
  include Sidekiq::Worker

  def perform(date_since = nil)
    date_since ||= 10.years.ago
    created_clubs_count = Club.where('created_at > ?', date_since).count
    puts "Total Clubs created #{created_clubs_count}"

    registered_users_count = User.where('created_at > ?', date_since).count
    puts "Total Users Created: #{registered_users_count}"
  end
end
