class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities
    end
  end
end
