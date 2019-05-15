class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities

      @annual_activities =
        @activities.where("acted_at >= ?", 1.year.ago.beginning_of_month).
          group_by { |a| a.acted_at.strftime("%Y-%m") }.sort_by { |month, _|month }.to_h

      current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
    end
  end
end
