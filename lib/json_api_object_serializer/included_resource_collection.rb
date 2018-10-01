# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class IncludedResourceCollection
    extend Forwardable

    def_delegators :included_resources, :add, :empty?, :size

    def self.build(includes, relationship_collection)
      new.tap do |collection|
        includes.each do |to_include|
          relationship_name, deep_including = to_include.to_s.split(".", 2)
          relationship = relationship_collection.find_by_serialized_name(relationship_name)

          collection.add(IncludedResource.new(relationship, deep_including))
        end
      end
    end

    def initialize
      @included_resources = Set.new
    end

    def serialize(resource, fieldset: NullFieldset.new, collection: false)
      return {} if empty?

      included_data =
        if collection
          serialize_for_resource_collection(resource, fieldset)
        else
          serialize_for_resource(resource, fieldset)
        end

      { included: included_data.uniq { |hash| hash.values_at(:type, :id) } }
    end

    private

    attr_reader :included_resources

    def serialize_for_resource(resource, fieldset)
      included_resources.map do |included_resource|
        included_resource.serialize(resource, fieldset: fieldset)
      end.flatten
    end

    def serialize_for_resource_collection(resource_collection, fieldset)
      Array(resource_collection)
        .map { |resource| serialize_for_resource(resource, fieldset) }
        .compact
        .flatten
    end
  end
end
