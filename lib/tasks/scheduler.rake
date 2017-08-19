namespace :reports do
  # e.g rake "reports:recent_registered_clubs_users[10/10/2017]"
  desc 'Registered clubs and users since'
  task :recent_registered_clubs_users, [:since] => :environment do |_t, args|
    date_since = Date.parse(args[:since])
    job = PlatformGrowthStats.new
    job.perform date_since
  end
end
