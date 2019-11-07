# START Gemfile
gem 'rails-i18n'
gem 'fast_jsonapi'
gem 'sentry-raven'

if yes?('This app will need to paginate results? (y/n)')
  gem 'kaminari'

  initializer 'kaminari_config.rb', File.read('../templates/initializers/kaminari_config.rb')
end

if yes?('This app will make external HTTP requests? (y/n)')
  gem 'rest-client'
end

gem_group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'fuubar'
  gem 'rspec-rails', '~> 3.8'

  ## Checkers
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

gem_group :test do
  gem 'simplecov', require: false
end

## Organize Gemfile
run 'eefgilm'
# END Gemfile

after_bundle do
  # START Rspec
  rails_command 'generate rspec:install', abort_on_failure: true

  run 'rm .rspec'
  file '.rspec', File.read('../templates/.rspec')
  # END Rspec

  # START initializers
  initializer '1_filtered_parameters.rb', File.read('../templates/initializers/1_filtered_parameters.rb')
  initializer '2_sentry_config.rb', File.read('../templates/initializers/2_sentry_config.rb')
  # END initializers

  # START GIT
  git :init
  git add: "."
  # END GIT
end
