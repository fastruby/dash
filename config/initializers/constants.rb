
if Rails.env.test?
  ORGANIZATIONS = %w( testdash ).freeze
  PIVOTAL_STATES = %w( unstarted ).freeze
else
  ORGANIZATIONS = ENV["GITHUB_ORGANIZATIONS"].split(",").freeze
  PIVOTAL_STATES = %w( unscheduled unstarted started finished delivered rejected accepted ).freeze
end

WEBHOOK_ACTIONS = %w( opened closed assigned unassigned review_requested review_request_removed ).freeze
