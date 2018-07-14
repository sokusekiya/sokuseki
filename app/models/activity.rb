class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :authentication

  validates :activity_type, presence: true
  validates :activity_id, presence: true, uniqueness: { scope: :activity_type }
  validates :act_at, presence: true
end
