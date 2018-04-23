source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.6"
gem "puma", "~> 3.7"
gem "pg", "~> 0.21"

gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 3.4"

gem "activeadmin", "~> 1.1"
gem "activeadmin-globalize", "~> 1.0.0.pre"
gem "activeadmin-orderable", "~> 0.1"
gem "active_model_serializers", "~> 0.10"
gem "acts_as_list", "~> 0.9"
gem "devise", "~> 4.4"
gem "friendly_id", "~> 5.1.0"
gem "geocoder", "~> 1.4"
gem "globalize", "~> 5.1"
gem "high_voltage", "~> 3.0.0"
gem "icalendar", "~> 2.4"
gem "jwt", "~> 2.1"
gem "phonelib", "~> 0.6.16"
gem "pundit", "~> 1.1"
gem "ransack", "~> 1.8"
gem "trix", "~> 0.11"
gem "yaml2csv", "~> 0.0.3", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "dotenv-rails"
  gem "selenium-webdriver"
end

group :development do
  gem "foreman"
  gem "web-console", ">= 3.3.0"
  gem "letter_opener", "~> 1.4"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
