class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def _run_options(options)
    options.merge(current_user: @current_user)
  end

  # TODO: Follow trailblazer auth logic
  def authenticate_request
    @current_user = nil
  end
end
