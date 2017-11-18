module Api
  module V1
    class NotesController < Api::V1::BaseController
      before_action :find_note, only: :delete

      def index
        result = ::V1::Note::Index.(params, current_user: current_user)
        render json: ::V1::Note::Representer::Index.new(result['models'])
      end

      def create
        result = ::V1::Note::Create.(params, current_user: current_user)
        if result.success?
          render json: ::V1::Note::Representer::Full.new(result['model']),
                 status: :created
        elsif result.policy_error?
          render json: {}, status: :unauthorized
        else
          render json: {
            errors: result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        result = ::V1::Note::Update.(params, current_user: current_user)
        if result.success?
          render json: ::V1::Note::Representer::Full.new(result['model']),
                 status: :created
        elsif result.policy_error?
          render json: {}, status: :unauthorized
        else
          error_messages = result['contract.default']&.errors&.full_messages || result['result.model']
          render json: { errors: error_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @note.destroy
          render json: @note, status: :ok
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def show
        result = ::V1::Note::Show.(params, current_user: current_user)
        if result.success?
          render json: ::V1::Note::Representer::Full.new(result['model']),
                 status: :ok
        elsif result.policy_error?
          render json: {}, status: :unauthorized
        else
          error_messages = result['contract.default']&.errors&.full_messages || result['result.model']
          render json: { errors: error_messages }, status: :unprocessable_entity
        end
      end

      private

      def find_note
        render_error(errors: ['Missing attributes']) unless params[:id]

        begin
          @note = @current_user.notes.find params[:id]
        rescue ActiveRecord::RecordNotFound
          render_error(errors: ["Can't find note"])
        end
      end

      def render_error(message)
        render json: message,
               status: :unprocessable_entity
      end
    end
  end
end
