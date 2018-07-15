class Authentication < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :access_token, presence: true

  def fetch_activities
    return [] unless provider == "github"

    client = Octokit::Client.new(access_token: access_token)
    client.auto_paginate = true

    events = client.user_events(name)

    events.each do |event|
      activity_id = event.id.to_s
      activity_type = event.type

      activity = Activity.find_or_initialize_by(
        user_id: self.user_id,
        authentication_id: self.id,
        activity_id: activity_id,
        activity_type: activity_type,
      )

      acted_at = event.created_at
      original_data = event.payload.to_h

      activity.acted_at = acted_at
      activity.original_data = original_data

      activity.save
    end
  end
end
