# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class RelationshipCollection
    extend Forwardable

    def_delegators :relationships, :add, :include?, :empty?

    def initialize
      @relationships = Set.new
    end

    def serialize(resource_object, fieldset: NullFieldset.new)
      relationships_from(fieldset).inject({}) do |hash, relationship|
        hash.merge(relationship.serialize(resource_object))
      end
    end

    def find_by_serialized_name(serialized_name)
      relationships.find { |relationship| relationship.serialized_name == serialized_name }
    end

    private

    attr_reader :relationships

    def relationships_from(fieldset)
      relationships.select { |relationship| fieldset.include?(relationship.serialized_name) }
    end
  end
end
