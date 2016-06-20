class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!

  layout 'visitors'

  def index
  end
end
