# frozen_string_literal: true

module JsonApiMatchers
  class MatchJsonApiData
    attr_reader :expected, :actual

    def initialize(id:, type:, attributes:)
      @expected = build_expected_data(id: id, type: type, attributes: attributes)
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

    def build_expected_data(id:, type:, attributes:)
      {
        data: {
          id: id.to_s,
          type: type.to_s,
          attributes: attributes.transform_keys { |key| key.to_s.tr("_", "-").to_sym }
        }
      }
    end
  end
end
