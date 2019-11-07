# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = ENV.fetch('SENTRY_DNS')
  config.logger = Logger.new('/dev/null')
  config.excluded_exceptions = []
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w[ production sandbox staging ]
end
