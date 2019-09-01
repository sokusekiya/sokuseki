Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get "/activities/on/:term_string", to: "activities/on_term#index", as: "activities_on_term"

  root to: "welcome#index"
end
