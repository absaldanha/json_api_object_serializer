# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class IncludedResourceCollection
    extend Forwardable

    def_delegators :included_resources, :add, :empty?

    def initialize
      @included_resources = Set.new
    end

    def serialize(resource, fieldset: NullFieldset.new)
      included_hash = included_resources.map do |included_resource|
        included_resource.serialize(resource, fieldset: fieldset)
      end.flatten

      included_hash.uniq { |hash| hash.values_at(:type, :id) }
    end

    private

    attr_reader :included_resources
  end
end
