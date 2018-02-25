require "redis"

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

      def setup_model!(model:, current_user:, **)
        model.user = current_user
        true
      end

      def set_ownership!(params:, model:, current_user:, **)
        current_user.tag(model, with: params[:note][:tag_list], on: :tags, skip_save: true)
        true
      end

      def ping_redis!(model:, **)
        redis = Redis.new
        if model.image_url.present?
          print "Submitting to Redis.."
          redis.publish FirstTouch::REDIS_NOTES_SUBSCRIBE_CHANNEL, "#{model.id} #{::Note.field_types[model.field_type]} #{model.image_url}"
        end
        true
      end
    end
  end
end