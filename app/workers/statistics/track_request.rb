module Statistics
  class TrackRequest
    include Sidekiq::Worker

    def perform(type = nil, metadata = {})
      return if type.nil?
      stats = Statistic.new(stat_type: type, metadata: metadata)
      return if stats.save
      logger.info "Statistsics failed to save: #{stats.errors.full_messages}"
    end
  end
end
