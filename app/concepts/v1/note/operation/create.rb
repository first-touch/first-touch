require 'redis'

module V1
  module Note
    class Create < Trailblazer::Operation
      step Model(::Note, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Note::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :note)
      step :set_ownership!
      step Trailblazer::Operation::Contract::Persist()
      step :ping_redis!

      def setup_model!(options,  **)
        options[:model].user = options[:current_user]
        true
      end

      def set_ownership!(options, params:,  **)
        options[:current_user].tag(options[:model], with: params[:note][:tag_list], on: :tags, skip_save: true)
        true
      end

      def ping_redis!(options, **)
        redis = Redis.new
        if options[:model].image_url.present?
          print 'Submitting to Redis..'
          redis.publish FirstTouch::REDIS_NOTES_SUBSCRIBE_CHANNEL, "#{model.id} #{::Note.field_types[model.field_type]} #{model.image_url}"
        end
        true
      end
    end
  end
end
