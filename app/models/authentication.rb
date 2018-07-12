class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :access_token, presence: true

  def fetch_activities
    if provider == 'github'
      client = Octokit::Client.new(access_token: access_token)
      client.auto_paginate = true

      events = client.user_events(name)

      events.each do |event|
        event_id = event.id
        event_type = event.type
        acted_at = event.created_at
        original_data = event.payload

        url = nil
        text = nil

        case event_type
        when 'CreateEvent'
          next
        when 'DeleteEvent'
          next
        when 'IssueCommentEvent'
          url = event.payload.comment.html_url
          text = event.payload.comment.body
        when 'IssuesEvent'
          url = event.payload.issue.html_url
          text = event.payload.issue.title
        when 'PullRequestEvent'
          url = event.payload.pull_request.html_url
          text = event.payload.pull_request.title
        when 'PullRequestReviewCommentEvent'
          url = event.payload.comment.html_url
          text = event.payload.comment.body
        when 'PushEvent'
          event.payload.commits.each do |commit|
            puts(
              [
                "CommitPushEvent##{commit.sha}",
                acted_at.strftime('%Y-%m-%d %H:%M'),
                "https://#{ENV['GHE_HOST']}/#{event.repo.name}/commit/#{commit.sha}",
                commit.message.to_s.gsub("\r\n", '').gsub("\n", '')[0..30],
              ].join("\t")
            )
          end

          next
        when 'ReleaseEvent'
          url = event.payload.release.html_url
          text = event.payload.release.body
        when 'WatchEvent'
          next
        else
          binding.pry
        end

        puts(
          [
            "#{event_type}##{event_id}",
            acted_at.strftime('%Y-%m-%d %H:%M'),
            url,
            text.to_s.gsub("\r\n", '').gsub("\n", '')[0..30],
          ].join("\t")
        )
      end

      nil
    end
  end
end
