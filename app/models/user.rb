class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :avatar_url, presence: true
end
