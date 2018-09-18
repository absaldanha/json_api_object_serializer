# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource, **options)
      if options[:collection]
        serialized_collection(resource, **options)
      else
        serialized_hash(resource, **options)
      end
    end

    private

    def serialized_hash(resource, **_options)
      result_hash = { data: nil }

      return result_hash if resource.nil?

      result_hash[:data] = identifier_of(resource)
      result_hash[:data].merge!(attributes_from(resource))
      result_hash[:data].merge!(relationships_from(resource))

      result_hash
    end

    def serialized_collection(resource_collection, **_options)
      return { data: [] } if resource_collection.nil?

      resource_collection.each_with_object(data: []) do |resource, result_hash|
        serialized_resource_hash = serialized_hash(resource)[:data]
        result_hash[:data].push(serialized_resource_hash) unless serialized_resource_hash.nil?
      end
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
