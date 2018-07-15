Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get "/activities/on/:month_string", to: "activities/on_month#index", as: "activities_on_month"

  root to: "welcome#index"
end
