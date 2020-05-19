desc "This task uses the github API to update pull requests"
task :update_pull_requests => :environment do
  puts "Updating pull requests..."
  PullRequest.sync_with_github
  puts "done."
end

desc "This task uses the github API to update issues"
task :update_issues => :environment do
  puts "Updating issues..."
  byebug
  Issue.sync_with_github
  puts "done."
end
