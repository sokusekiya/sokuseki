Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  root to: "welcome#index"
end
