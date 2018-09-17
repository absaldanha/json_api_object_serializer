# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource)
      resource_hash(resource)
    end

    private

    def resource_hash(resource)
      result_hash = { data: nil }
      result_hash[:data] = identifier_of(resource)
      result_hash[:data].merge!(attributes_from(resource))
      result_hash[:data].merge!(relationships_from(resource))

      result_hash
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
