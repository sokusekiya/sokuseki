Octokit.configure do |c|
  c.api_endpoint = "https://#{ENV['GHE_HOST']}/api/v3/"
end
