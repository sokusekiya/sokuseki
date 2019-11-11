class SharedLink < ApplicationRecord
  belongs_to :user

  scope :available, -> {
    where("expired_at > ?", Time.current)
  }

  scope :on, ->(term) {
    where(on: term)
  }
end
