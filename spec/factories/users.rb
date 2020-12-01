FactoryBot.define do
  factory :user  do
    name { "testuser" }
    provider { "github" }
    id { 3 }
    uid { "123" }
  end
end
