class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :authentication

  validates :activity_type, presence: true
  validates :activity_id, presence: true, uniqueness: { scope: :activity_type }
  validates :acted_at, presence: true

  scope :on, ->(string) {
    if string =~ /(\d{4})-(1st|2nd)/
      year = Regexp.last_match[0].to_i
      if Regexp.last_match[1] == "1st"
        where(acted_at: (Time.new(year))..(Time.new(year, 6).end_of_month))
      else
        where(acted_at: (Time.new(year, 7))..(Time.new(year, 12).end_of_month))
      end
    else
      where(acted_at: Time.zone.parse("#{string}-01").all_month)
    end
  }

  scope :in_the_last_year, -> {
    where("acted_at >= ?", 1.year.ago.beginning_of_month)
  }

  scope :issue_and_pr, -> {
    where(activity_type: %w[IssuesEvent PullRequestEvent])
  }
end
