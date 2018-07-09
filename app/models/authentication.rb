class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :access_token, presence: true
end
