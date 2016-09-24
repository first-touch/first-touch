class Api::V1::NetworkController < Api::V1::BaseController
  def index
    # TODO: Needs improvement as network grows
    # will probably be impossible to build the whole graph at once
    render json: { network: current_user.network }
  end
end
