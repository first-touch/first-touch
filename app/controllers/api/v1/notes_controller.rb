module Api
  module V1
    class NotesController < Api::V1::BaseController
      before_action :find_note, only: :delete

      def index
        result = FirstTouch::Endpoint.(
          ::V1::Note::Index,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Index
        )
        render json: result[:data], status: result[:status]
      end

      def create
        result = FirstTouch::Endpoint.(
          ::V1::Note::Create,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Full
        )
        render json: result[:data], status: result[:status]
      end

      def update
        result = FirstTouch::Endpoint.(
          ::V1::Note::Update,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Full
        )
        render json: result[:data], status: result[:status]
      end

      def destroy
        if @note.destroy
          render json: @note, status: :ok
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def show
        result = FirstTouch::Endpoint.(
          ::V1::Note::Show,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Full
        )
        render json: result[:data], status: result[:status]
      end

      def labels
        result = FirstTouch::Endpoint.(
          ::V1::Note::Labels,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Labels
        )
        render json: result[:data], status: result[:status]
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
