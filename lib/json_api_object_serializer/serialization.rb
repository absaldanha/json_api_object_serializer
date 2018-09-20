# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource, **options)
      data =
        if options[:collection]
          serialized_collection(resource, **options)
        else
          serialized_hash(resource, **options)
        end

      { data: data }
    end

    private

    def serialized_hash(resource, **_options)
      return unless resource

      identifier_of(resource)
        .merge(attributes_from(resource))
        .merge(relationships_from(resource))
    end

    def serialized_collection(resource_collection, **_options)
      Array(resource_collection)
        .map { |resource| serialized_hash(resource) }
        .compact
    end

    def identifier_of(resource)
      identifier.serialize(resource)
    end

    def attributes_from(resource)
      { attributes: resource_attributes_from(resource) }
    end

    def relationships_from(resource)
      return {} if relationship_collection.empty?

      { relationships: relationship_collection.serialize(resource) }
    end

    def resource_attributes_from(resource)
      attribute_collection.serialize(resource)
    end
  end
end
