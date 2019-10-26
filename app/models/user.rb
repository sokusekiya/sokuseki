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
        name: name,
        avatar_url: avatar_url,
      )
      user.authentications.create(
        provider: provider,
        uid: uid,
        name: name,
        access_token: access_token,
      )

      user
    end
  end
end
