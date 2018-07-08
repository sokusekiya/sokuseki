Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :github, ENV['GHE_APP_KEY'], ENV['GHE_APP_SECRET'], {
    client_options: {
      site: "https://#{ENV['GHE_HOST']}/api/v3",
      authorize_url: "https://#{ENV['GHE_HOST']}/login/oauth/authorize",
      token_url: "https://#{ENV['GHE_HOST']}/login/oauth/access_token",
    },
    scope: 'user,repo'
  }
end
