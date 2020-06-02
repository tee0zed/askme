source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2', '>= 6.0.2.2'

gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'uglifier', '~> 2.7', '>= 2.7.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'simple_form'
gem 'rinku'
gem 'friendly_id', '~> 5.2.4'

# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end
