class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :authentication

  validates :activity_type, presence: true
  validates :activity_id, presence: true, uniqueness: { scope: :activity_type }
  validates :acted_at, presence: true

  scope :on, ->(month_string) {
    where(acted_at: Time.zone.parse("#{month_string}-01").all_month)
  }

  scope :on_month_ago, ->(month_ago) {
    where(acted_at: month_ago.month.ago.all_month)
  }

  scope :issue_and_pr, -> {
    where(activity_type: %w[IssuesEvent PullRequestEvent])
  }
end
