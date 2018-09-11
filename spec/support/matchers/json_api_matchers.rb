# frozen_string_literal: true

require_relative "json_api_matchers/match_json_api_data"

module JsonApiMatchers
  def match_json_api_data(id:, type:, attributes:, relationships: {})
    MatchJsonApiData.new(id: id, type: type, attributes: attributes, relationships: relationships)
  end
end
