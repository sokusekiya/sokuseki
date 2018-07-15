class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :authentication

  validates :activity_type, presence: true
  validates :activity_id, presence: true, uniqueness: { scope: :activity_type }
  validates :acted_at, presence: true

  scope :on, ->(month_string) {
    where(acted_at: Time.zone.parse("#{month_string}-01").all_month)
  }
end
