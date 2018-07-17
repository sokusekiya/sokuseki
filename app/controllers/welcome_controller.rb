class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities

      current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
    end
  end
end
