class WebhooksController < ApplicationController
  protect_from_forgery except: :github_webhooks

  def github_webhooks
    payload = params["payload"]
    response = JSON.parse(payload)
    PullRequest.new.create_or_update_from_webhook(response)
  end
end
