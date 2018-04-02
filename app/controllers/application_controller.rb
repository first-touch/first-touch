class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def _run_options(options)
    options.merge(current_user: @current_user)
  end
end
