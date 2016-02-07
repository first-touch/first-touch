class VisitorsController < ApplicationController
  layout 'application'

  def home
    if current_user.nil?
      index
      return
    end
  end

  def index
    @interested_person = InterestedPerson.new
    render :index, layout: 'visitors'
  end
end
