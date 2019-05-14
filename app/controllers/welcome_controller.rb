class WelcomeController < ApplicationController
  def index
    if signed_in?
      @activities = current_user.activities
      @yearly_activities = (0..12).each_with_object([]) do |month, activities|
        activities.push(@activities.on_month_ago(month))
      end

      current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
    end
  end
end
