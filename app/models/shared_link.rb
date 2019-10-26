class SharedLink < ApplicationRecord
  belongs_to :user

  scope :available, -> {
    where("expired_at > ?", Time.zone.now)
  }

  scope :on, ->(term) {
    where(on: term)
  }
end
