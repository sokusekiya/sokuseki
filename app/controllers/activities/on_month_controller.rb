class Activities::OnMonthController < ApplicationController
  before_action :redirect_to_root_unless_signed_in

  def index
    @month_string = params[:month_string]
    @activities = current_user.activities.on(@month_string)
  end
end
