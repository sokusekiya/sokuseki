Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  get "/activities/on/:term_string", to: "activities/on_term#index", as: "activities_on_term", constraints: { term_string: /\d{4}-(1st|2nd)/ }
  get "/activities/on/:month_string", to: "activities/on_month#index", as: "activities_on_month", constraints: { month_string: /\d{4}-\d{2}/ }

  root to: "welcome#index"
end
