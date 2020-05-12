FactoryBot.define do
  factory :issue do
    title { "MyIssue" }
    issue_number { "123" }
    issue_link { "http://test_issue" }
    repository_link { "http://repo_issue" }
    state { "opened" }
    repository_name { "test/test" }
  end
end
