desc "This task uses the github API to update pull requests"
task :update_pull_requests => :environment do
  puts "Updating pull requests..."
  PullRequest.sync_with_github
  puts "done."
end
