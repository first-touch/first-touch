module Api
  module V1
    class NotesController < Api::V1::BaseController
      before_action :find_note, only: :delete
      skip_before_action :authenticate_request, only: :field_types

      def index
        result = ::V1::Note::Index.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Note::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def index_by_tag
        result = ::V1::Note::IndexByTag.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Note::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Note::Create.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Note::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def update
        result = ::V1::Note::Update.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Note::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def destroy
        if @note.destroy
          render json: @note, status: :ok
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def field_types
        render json: Note.field_types
      end

      def show
        result = ::V1::Note::Show.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Note::Representer::FullWithElements)
        render json: response[:data], status: response[:status]
      end

      def tags
        result = FirstTouch::Endpoint.(
          ::V1::Note::Tags,
          args: [params, current_user: current_user],
          representer: ::V1::Note::Representer::Tags
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
