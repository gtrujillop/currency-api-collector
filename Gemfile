source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'mongoid', '~> 8.1'
gem "foreman"
gem "dotenv"
gem 'logger'
gem "grape"
gem "grape-entity"
gem "grape-swagger"
gem "puma"
gem "rack"
gem "rack-cors"
gem "rest-client"
gem "securerandom"
gem "sidekiq-scheduler", "~> 5.0", ">= 5.0.2"
gem "yaml"

group :test, :development do
  gem "factory_bot"
  gem "pry"
  gem "rspec", "~> 3.2.0"
  gem "rubocop", require: false
  gem "shoulda-matchers", "~> 5.0"
  gem "timecop"
end

group :test do
  gem "rspec-sidekiq"
end

ruby '~> 3.2.0'
