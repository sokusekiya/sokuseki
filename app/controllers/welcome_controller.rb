class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities
      @yearly_activities = (0..12).each_with_object([]) do |month, activities|
        on = month.month.ago.year.to_s + "-" + sprintf("%02d", month.month.ago.month.to_s)
        activity = { on: on, activity: @activities.on_month_ago(month) }
        activities.push(activity)
      end

      current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
    end
  end
end
