# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class RelationshipCollection
    extend Forwardable

    def_delegators :relationships, :size, :include?, :empty?

    def initialize
      @relationships = Set.new
    end

    def add(relationship)
      relationships.add(relationship)
    end

    def serialized_relationships_of(resource_object)
      relationships.each_with_object({}) do |relationship, hash|
        hash.merge!(relationship.serialization_of(resource_object))
      end
    end

    private

    attr_reader :relationships
  end
end
