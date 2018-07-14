class WelcomeController < ApplicationController
  def index
    @activities = current_user.activities.order(acted_at: :desc) if signed_in?
  end
end
