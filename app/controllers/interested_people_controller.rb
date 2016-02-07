class InterestedPeopleController < ApplicationController
  def create
    @interested_person = InterestedPerson.create interested_person_params
    flash[:message] = 'Thanks for registering your interest. You\'ll be updated when time comes! <3'
    redirect_to :root
  end

  private
  def interested_person_params
    params.require(:interested_person).permit(:name, :email)
  end
end
