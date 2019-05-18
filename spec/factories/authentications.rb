FactoryBot.define do
  factory :authentication do
    provider { "github" }
    sequence(:uid, &:to_s)
    name { "yinm" }
    access_token { "abcde12345" }

    user { nil }
  end
end
