source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "rails", "~> 6.0.1"

gem "bootsnap", ">= 1.1.0", require: false
gem "jbuilder", "~> 2.9"
gem "octokit"
gem "omniauth-github"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.2"
gem "sass-rails", "~> 6.0"
gem "sentry-raven"
gem "slim-rails"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "mini_racer"
  gem "pry"
  gem "rspec-rails", "~> 3.9"
  gem "rubocop", require: false
  gem "rubocop-performance"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.3"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
