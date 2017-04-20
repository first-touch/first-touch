module Api
  module V1
    class SessionPlansController < Api::V1::BaseController
      before_filter :find_session_plan, except: [:index, :create]

      def index
        render json: @current_user.session_plans
      end

      def create
        @session_plan = SessionPlan.new(session_plan_params)

        if @session_plan.save
          render json: @session_plan, status: :created
        else
          render json: @session_plan.errors, status: :unprocessable_entity
        end
      end

      def update
        @session_plan.update_attributes(session_plan_params)
        if @session_plan.save
          render json: @session_plan, status: :ok
        else
          render json: @session_plan.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @session_plan.destroy
          render json: @session_plan, status: :ok
        else
          render json: @session_plan.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @session_plan, status: :ok
      end

      private

      def session_plan_params
        params.require(:session_plan).permit(:name,
                                             {:tags => []},
                                             {:image_attributes=> [
                                                :file
                                             ]}
                                             ).merge(user_id: @current_user.id)
      end

      def find_session_plan
        # TODO: make this an application error
        unless params[:id]
          render_error({ errors: ["Missing attributes"] })
        end

        begin
          @session_plan = @current_user.session_plans.find params[:id]
        rescue ActiveRecord::RecordNotFound => e
          render_error({ errors: ["Can't find session"] })
        end
      end

      def render_error(message)
        render json: message,
               status: :unprocessable_entity
      end
    end
  end
end
