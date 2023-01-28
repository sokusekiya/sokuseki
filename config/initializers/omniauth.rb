Rails.application.config.middleware.use OmniAuth::Builder do
  ghe_host = ENV.fetch("GHE_HOST", nil)

  provider :github, ENV.fetch("GHE_APP_KEY", nil), ENV.fetch("GHE_APP_SECRET", nil), {
    client_options: {
      site: "https://#{ghe_host}/api/v3",
      authorize_url: "https://#{ghe_host}/login/oauth/authorize",
      token_url: "https://#{ghe_host}/login/oauth/access_token",
    },
    scope: "user,repo",
  }
end
