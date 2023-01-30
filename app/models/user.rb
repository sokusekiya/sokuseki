class User < ApplicationRecord
  has_many :authentications
  has_many :activities
  has_many :shared_links

  validates :name, presence: true, uniqueness: true
  validates :avatar_url, presence: true

  def self.create_with(omniauth)
    provider = omniauth.dig("provider")
    uid = omniauth.dig("uid")
    name = omniauth.dig("info", "nickname")
    avatar_url = omniauth.dig("info", "image")
    access_token = omniauth.dig("credentials", "token")

    ApplicationRecord.transaction do
      user = User.create(
        name:,
        avatar_url:,
      )
      user.authentications.create(
        provider:,
        uid:,
        name:,
        access_token:,
      )

      user
    end
  end

  def has_available_link_on?(term)
    @shared_links ||= shared_links.available.all
    @shared_links.find { |s| s.on == term }
  end
end
