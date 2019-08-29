class WelcomeController < ApplicationController
  def index
    return unless signed_in?

    @activities = current_user.activities

    @terms =
      @activities.map { |a| at = a.acted_at; "%d-%s" % [at.year, %w(1st 2nd)[at.month / 7]] }.uniq.sort.reverse
    @months =
      @activities.map { |a| a.acted_at.strftime("%Y-%m") }.uniq.sort.reverse

    @target_duration = (0..12).map { |n| n.month.ago.strftime("%Y-%m") }.reverse

    @annual_activities =
      @activities.in_the_last_year.
        group("TO_CHAR(acted_at, 'YYYY-MM')", :activity_type).order("TO_CHAR(acted_at, 'YYYY-MM')").count.
        each_with_object(Hash.new { |h, k| h[k] = {} }) do |(key, value), result|
        acted_month, activity_type = key
        result[activity_type][acted_month] = value
      end

    current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
  end
end
