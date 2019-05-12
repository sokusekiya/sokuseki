FactoryBot.define do
  factory :activity do
    sequence(:activity_id, &:to_s)
    activity_type { "IssuesEvent" }
    acted_at { Time.current }

    authentication
    user { authentication.user }

    trait :commit_comment_event do
      activity_type { "CommitCommentEvent" }
    end

    trait :issue_event do
      activity_type { "IssuesEvent" }
    end

    trait :pull_request_event do
      activity_type { "PullRequestEvent" }
    end
  end
end
