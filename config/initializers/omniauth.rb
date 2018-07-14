Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  ghe_host = ENV["GHE_HOST"]

  provider :github, ENV["GHE_APP_KEY"], ENV["GHE_APP_SECRET"], {
    client_options: {
      site: "https://#{ghe_host}/api/v3",
      authorize_url: "https://#{ghe_host}/login/oauth/authorize",
      token_url: "https://#{ghe_host}/login/oauth/access_token",
    },
    scope: "user,repo",
  }
end
