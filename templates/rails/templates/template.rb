app_name = `echo -n $APP_NAME`

# START Gemfile
gem 'rails-i18n'
gem 'fast_jsonapi'
gem 'sentry-raven'

if yes?('This app will need to paginate results? (y/n)')
  gem 'kaminari'

  initializer 'kaminari_config.rb', File.read('../../templates/initializers/kaminari_config.rb')
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
  gem 'rubocop', '~> 0.89', require: false
  gem 'rubocop-rspec', require: false
end

gem_group :test do
  gem 'simplecov', require: false
end

## Organize Gemfile
run 'eefgilm'
# END Gemfile

file '.env', <<-CODE
  DATABASE_HOST=db
  DATABASE_USERNAME=#{app_name}
  DATABASE_PASSWORD=password
  SENTRY_DNS=nil
  CODE

after_bundle do
  # START database config
  run "rm -f config/database.yml"
  file 'config/database.yml', File.read('../../templates/database.yml')
  # END database config

  # START Rspec
  rails_command 'generate rspec:install', abort_on_failure: true

  run 'rm .rspec'
  file '.rspec', File.read('../../templates/.rspec')
  # END Rspec

  # START initializers
  initializer '1_filtered_parameters.rb', File.read('../../templates/initializers/1_filtered_parameters.rb')
  initializer '2_sentry_config.rb', File.read('../../templates/initializers/2_sentry_config.rb')
  # END initializers

  # START Docker config
  file 'Dockerfile', File.read('../../templates/Dockerfile').gsub('#{app_name}', app_name)
  file 'docker-compose.yml', File.read('../../templates/docker-compose.yml').gsub('#{app_name}', app_name)
  file '.dockerignore', File.read('../../templates/.dockerignore')
  file 'entrypoint.sh', File.read('../../templates/entrypoint.sh')
  # END Docker config

  # START Circle CI
  file '.circleci/config.yml', File.read('../../templates/.circleci/config.yml').gsub('#{app_name}', app_name)
  # END Circle CI

  # START Circle CI
  file '.codeclimate.yml', File.read('../../templates/.codeclimate.yml')
  # END Circle CI

  # START PR template
  file 'pull_request_template.md', File.read('../../templates/pull_request_template.md')
  # END PR template

  # START spec supports
  file 'spec/support/json_body.rb', File.read('../../templates/spec/support/json_body.rb')
  file 'spec/support/simple_cov.rb', File.read('../../templates/spec/support/simple_cov.rb')

  insert_into_file 'spec/rails_helper.rb', "Dir['./spec/support/**/*.rb'].each { |f| require f }\n", :after => "require 'spec_helper'\n"
  # END spec supports

  # START GIT
  git :init
  git add: "."

  if yes?('Did you want to set origin git remote as git@github.com:doghero/#{app_name}.git? (y/n)')
    run 'git remote add origin git@github.com:doghero/#{app_name}.git'
  end
  # END GIT
end
