# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource, **options)
      fieldset = Fieldset.build(identifier.type, options.fetch(:fields, {}))

      data =
        if options[:collection]
          serialized_collection(resource, fieldset: fieldset)
        else
          serialized_hash(resource, fieldset: fieldset)
        end

      { data: data }
    end

    private

    def serialized_hash(resource, fieldset:)
      return unless resource

      identifier_of(resource)
        .merge(attributes_from(resource, fieldset: fieldset))
        .merge(relationships_from(resource, fieldset: fieldset))
    end

    def serialized_collection(resource_collection, fieldset:)
      Array(resource_collection)
        .map { |resource| serialized_hash(resource, fieldset: fieldset) }
        .compact
    end

    def identifier_of(resource)
      identifier.serialize(resource)
    end

    def attributes_from(resource, fieldset:)
      attributes = attribute_collection.serialize(resource, fieldset: fieldset)
      attributes.empty? ? {} : { attributes: attributes }
    end

    def relationships_from(resource, fieldset:)
      return {} if relationship_collection.empty?

      relationships = relationship_collection.serialize(resource, fieldset: fieldset)
      relationships.empty? ? {} : { relationships: relationships }
    end
  end
end
