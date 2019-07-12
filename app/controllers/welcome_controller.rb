class WelcomeController < ApplicationController
  def index
    return unless signed_in?

    @activities = current_user.activities

    @target_duration = (0..12).map { |var| var.month.ago.strftime("%Y-%m") }.reverse

    @annual_activities =
      @activities.where("acted_at >= ?", 1.year.ago.beginning_of_month).
        group("TO_CHAR(acted_at, 'YYYY-MM')", :activity_type).order("TO_CHAR(acted_at, 'YYYY-MM')").count.inject({}) do |result, (key, value)|
          acted_at, activity_type = key
        result[activity_type] ||= {}
        result[activity_type][acted_at] = value
        result
      end

    current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
  end
end
