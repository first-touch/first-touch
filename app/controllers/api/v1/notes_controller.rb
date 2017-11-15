module Api
  module V1
    class NotesController < Api::V1::BaseController
      before_action :find_note, except: %i[index create]

      def index
        render json: @current_user.notes
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
        @note.update_attributes(note_params)
        if @note.save
          render json: ::V1::Note::Representer::Full.new(@note).as_json,
                 status: :ok
        else
          render json: @note.errors, status: :unprocessable_entity
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
        render json: @note, status: :ok
      end

      private

      def note_params
        params.require(:note).permit(:name,
                                     :content,
                                     labels: [],
                                     image_attributes: [:file])
              .merge(user_id: @current_user.id)
      end

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
