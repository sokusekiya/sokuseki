class SharedLink < ApplicationRecord
  belongs_to :user
  before_validation :build_param

  validates :token, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :on, presence: true, length: { maximum: 255 }

  scope :available, -> {
    where("expired_at > ?", Time.current)
  }

  scope :on, ->(term) {
    where(on: term)
  }

  private

    def build_param
      self.token = SecureRandom.hex(32)
      self.expired_at = 30.minutes.after
    end
end
