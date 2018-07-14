Octokit.configure do |c|
  ghe_host = ENV["GHE_HOST"]
  c.api_endpoint = "https://#{ghe_host}/api/v3/"
end
