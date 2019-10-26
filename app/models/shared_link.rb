class SharedLink < ApplicationRecord
  belongs_to :user

  scope :available, -> {
    where("expired_at > ?", Time.zone.now)
  }
end
