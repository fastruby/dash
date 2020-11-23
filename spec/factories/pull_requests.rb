FactoryBot.define do
  factory :pull_request do
    title { "test_pr" }
    pull_request_number { "123" }
    pull_request_link { "http://test_pr" }
    repository_link { "http://repo_pr" }
    state { "open" }
    repository_name { "test/test"}
    author_id { 3 }
    author_name {"User4"}
  end
end
