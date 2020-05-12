FactoryBot.define do
  factory :user  do
    name { "testuser" }
    provider { "github" }
    uid { "123" }
  end
end
