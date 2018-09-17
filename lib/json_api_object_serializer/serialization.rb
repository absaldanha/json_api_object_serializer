# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.included(base)
      base.extend DSL
      base.extend ClassMethods
    end

    def to_hash(resource_object)
      self.class.serialize_to_hash(resource_object)
    end

    module ClassMethods
      def serialize_to_hash(resource_object)
        result_hash = { data: nil }
        result_hash[:data] = identifier_of(resource_object)
        result_hash[:data].merge!(attributes_from(resource_object))
        result_hash[:data].merge!(relationships_from(resource_object))

        result_hash
      end

      def identifier_of(resource_object)
        @identifier.serialized_identifier_of(resource_object)
      end

      def attributes_from(resource_object)
        { attributes: resource_attributes_from(resource_object) }
      end

      def relationships_from(resource_object)
        return {} if @relationship_collection.empty?

        { relationships: @relationship_collection.serialized_relationships_of(resource_object) }
      end

      def resource_attributes_from(resource_object)
        @attribute_collection.serialized_attributes_of(resource_object)
      end
    end
  end
end
