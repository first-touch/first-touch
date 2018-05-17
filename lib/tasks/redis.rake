require "redis"
namespace :notes do
  # e.g rake "notes:listen"
  desc 'Listen to Python server publish messages.'
  task listen: :environment do
    redis = Redis.new
    redis.subscribe(FirstTouch::REDIS_NOTES_PUBLISH_CHANNEL) do |on|
      print "Listening to new stuff.."
      on.message do |channel, message|
        data = JSON.parse(message)
        ::V1::Note::MLUpdate.(id: data["id"], note: { elements: data["data"]})
        print "Added new elements for Note #{data['id']}"
      end
    end
  end
end
