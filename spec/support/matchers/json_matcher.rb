# frozen_string_literal: true

require_relative "json_matcher/match_json_schema"

module JsonMatcher
  def match_json_schema(schema)
    MatchJsonSchema.new(schema)
  end

  def match_jsonapi_schema
    match_json_schema(:jsonapi)
  end
end
