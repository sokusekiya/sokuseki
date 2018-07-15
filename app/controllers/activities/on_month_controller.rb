class Activities::OnMonthController < ApplicationController
  def index
    month_string = params[:month_string]
    @activities = current_user.activities.on(month_string)
  end
end
