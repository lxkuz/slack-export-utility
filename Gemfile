source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
gem 'axlsx'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bulk_insert'
gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails', groups: [:development, :test]
gem 'faraday'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'omniauth-slack'
gem 'overcommit'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.3'
gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
