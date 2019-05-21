class WelcomeController < ApplicationController
  def index
    return unless signed_in?

    @activities = current_user.activities

    @annual_activities =
      @activities.where("acted_at >= ?", 1.year.ago.beginning_of_month).
        group("TO_CHAR(acted_at, 'YYYY-MM')", :activity_type).order("TO_CHAR(acted_at, 'YYYY-MM')").count

    current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
  end
end
