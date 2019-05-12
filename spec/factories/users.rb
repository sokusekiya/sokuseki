FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "yinm#{n}" }
    avatar_url { "https://example.com/avatars" }
  end
end
