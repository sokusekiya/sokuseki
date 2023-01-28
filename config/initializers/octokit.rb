Octokit.configure do |c|
  ghe_host = ENV.fetch("GHE_HOST", nil)
  c.api_endpoint = "https://#{ghe_host}/api/v3/"
end
