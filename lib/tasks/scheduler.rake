desc "This task uses the github API to update pull requests"
task :update_pull_requests => :environment do
  puts "Updating pull requests..."
  PullRequest.sync_with_github
  puts "done."
end

desc "This task uses the github API to update issues"
task :update_issues => :environment do
  puts "Updating issues..."
  Issue.sync_with_github
  puts "done."
end

desc "This task uses the Pivotal Tracker API to update the stories"
task :update_pivotal_stories => :environment do
  puts "Updating pivotal stories..."
  PivotalStory.sync_with_pivotal_tracker
  puts "done."
end
