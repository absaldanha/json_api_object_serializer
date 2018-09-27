# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource, **options)
      fieldset = Fieldset.build(identifier.type, options.fetch(:fields, {}))
      included = build_included_resources(options.fetch(:include, []))

      serialized_meta
        .merge(serialized_data(resource, fieldset: fieldset, collection: options[:collection]))
        .merge(serialized_included(resource, fieldset: fieldset, included: included))
    end

    private

    def build_included_resources(includes)
      IncludedResourceCollection.new.tap do |included_resource_collection|
        includes.each do |to_include|
          relationship = relationship_collection.find_by_serialized_name(to_include)
          included_resource_collection.add(IncludedResource.new(relationship))
        end
      end
    end

    def serialized_meta
      return {} if meta_object.empty?

      { meta: meta_object.serialize }
    end

    def serialized_data(resource, fieldset:, collection:)
      data =
        if collection
          serialized_collection(resource, fieldset: fieldset)
        else
          serialized_hash(resource, fieldset: fieldset)
        end

      { data: data }
    end

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

    def serialized_included(resource, fieldset:, included:)
      return {} if included.empty?

      { included: included.serialize(resource, fieldset: fieldset) }
    end
  end
end
