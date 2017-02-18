module Api::V1
  class VisitorsController < Api::V1::BaseController
    skip_before_action :authenticate_request

    def pre_register
      ip = InterestedPerson.create(params.permit(:email, :name))
      if ip.save
        render json: { message: 'Registered successfully' }
      else
        render json: { error: ip.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
