# frozen_string_literal: true

require "json-schema"

module JsonMatcher
  class MatchJsonSchema
    def initialize(schema)
      @expected_schema = schema
      @expected_schema_path = "#{Dir.pwd}/spec/support/schemas/#{schema}.json"
    end

    def matches?(json_response)
      @actual_json_response = json_response
      JSON::Validator.validate(expected_schema_path, actual_json_response)
    end

    def description
      "match JSON schema #{expected_schema}"
    end

    def failure_message
      JSON::Validator.fully_validate(expected_schema_path, actual_json_response).first
    end

    private

    attr_reader :expected_schema_path, :actual_json_response, :expected_schema
  end
end
