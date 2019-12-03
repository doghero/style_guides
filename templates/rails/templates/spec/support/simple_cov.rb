# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/models/application_record.rb'
  add_filter 'channels/application_cable/channel.rb'
  add_filter 'channels/application_cable/connection.rb'
  add_filter 'controllers/application_controller.rb'
  add_filter 'jobs/application_job.rb'
  add_filter 'mailers/application_mailer.rb'

  add_group 'Services', 'services'
  add_group 'Contracts', 'contracts'
end
