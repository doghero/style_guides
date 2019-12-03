# frozen_string_literal: true

def json_body
  parsed_body = JSON.parse(response.body)
  parsed_body.deep_symbolize_keys! if parsed_body.is_a? Hash

  parsed_body
end
