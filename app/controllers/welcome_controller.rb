class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities
      @annual_activities = (0..12).each_with_object([]) do |month_amount, activities|
        target_month = month_amount.month.ago.year.to_s + "-" + sprintf("%02d", month_amount.month.ago.month.to_s)
        activity = { on: target_month, activity: @activities.month_ago(month_amount) }
        activities.push(activity)
      end
      @annual_activities.reverse!

      current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
    end
  end
end
