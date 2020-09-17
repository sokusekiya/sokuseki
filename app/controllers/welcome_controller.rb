class WelcomeController < ApplicationController
  TERMS = %w[1st 2nd].freeze

  def index
    return unless signed_in?

    @activities = current_user.activities
    @terms = extract_terms(@activities)
    @months = extract_months(@activities)
    @target_duration = (0..12).map { |n| n.month.ago.strftime("%Y-%m") }.reverse
    @annual_activities = extract_annual(@activities)
    @shared_links = extract_shared_links(current_user.shared_links)

    current_user.authentications.each(&:fetch_activities) if @activities.count.zero?
  end

  private

    def extract_terms(activities)
      activities.map { |a|
        at = a.acted_at
        "%<year>d-%<term>s" % { year: at.year, term: TERMS[at.month / 7] }
      }.uniq.sort.reverse
    end

    def extract_months(activities)
      activities.map { |a|
        a.acted_at.strftime("%Y-%m")
      }.uniq.sort.reverse
    end

    def extract_annual(activities)
      activities.in_the_last_year.
        group("TO_CHAR(acted_at, 'YYYY-MM')", :activity_type).order("TO_CHAR(acted_at, 'YYYY-MM')").count.
        each_with_object(Hash.new { |h, k| h[k] = {} }) { |(key, value), result|
        acted_month, activity_type = key
        result[activity_type][acted_month] = value
      }
    end

    def extract_shared_links(shared_links)
      shared_links.each_with_object({}) do |obj, hash|
        hash[obj.on] = { expired_at: obj.expired_at.strftime("%m-%d %H:%M"), token: obj.token }
      end
    end
end
