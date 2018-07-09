class User < ApplicationRecord
  has_many :authentications

  validates :name, presence: true, uniqueness: true
  validates :avatar_url, presence: true
end
