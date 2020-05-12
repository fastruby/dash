require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: "todos#index"

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  delete "/signout" => "sessions#destroy", :as => :signout

  get "/home" => "home#index"

  post "/github_webhooks" => "webhooks#github_webhooks"

  get "/todos" => "todos#index"
  patch "/todos/update_pull_requests" => "todos#update_pull_requests"
  patch "/todos/update_issues" => "todos#update_issues"
  patch "/todos/update_pivotal" =>"todos#update_pivotal"

  get "/pivotal/new" => "pivotal#new"
  post "/pivotal/new" => "pivotal#create"
end
