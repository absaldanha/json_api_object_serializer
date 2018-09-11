# frozen_string_literal: true

module JsonApiMatchers
  class MatchJsonApiData
    attr_reader :expected, :actual

    def initialize(id:, type:, attributes:, relationships: {})
      @expected = build_expected_data(id, type, attributes, relationships)
    end

    def matches?(payload)
      @actual = payload
      @expected == @actual
    end

    def diffable?
      true
    end

    def failure_message
      "\nexpected #{actual} to match #{expected}"
    end

    private

    def build_expected_data(id, type, attributes, relationships = {})
      {}.tap do |hash|
        hash[:data] = build_data(id, type, attributes)
        hash[:data].merge(build_relationships(relationships))
      end
    end

    def build_data(id, type, attributes)
      { id: id.to_s, type: type.to_s, attributes: build_attributes(attributes) }
    end

    def build_attributes(attributes)
      attributes.transform_keys { |key| key.to_s.tr("_", "-").to_sym }
    end

    def build_relationships(relationships)
      return {} if relationships.empty?

      Hash[:relationships, {}].tap do |hash|
      end
    end
  end
end
