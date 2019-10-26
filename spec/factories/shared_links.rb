FactoryBot.define do
  factory :shared_link do
    user { nil }
    expired_at { "2019-10-26 18:26:58" }
    on { "MyString" }
    token { "MyString" }
  end
end
