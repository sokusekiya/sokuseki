class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities

      if @activities.count.zero?
        current_user.authentications.each(&:fetch_activities)
      end
    end
  end
end
