# frozen_string_literal: true

module JsonApiObjectSerializer
  module Serialization
    def self.extended(base)
      base.extend DSL
    end

    def to_hash(resource, **options)
      fieldset = Fieldset.build(identifier.type, options.fetch(:fields, {}))
      collection = options.fetch(:collection, false)
      including = options.fetch(:include, [])

      serialized_related_info(resource)
        .merge(serialized_data(resource, fieldset, collection))
        .merge(serialized_included(resource, fieldset, including, collection))
    end

    def to_json(resource, **options)
      MultiJson.dump(to_hash(resource, options))
    end

    private

    def serialized_related_info(resource)
      serialized_meta.merge(serialized_links(resource))
    end

    def serialized_meta
      meta_object.serialize
    end

    def serialized_links(resource)
      link_collection.serialize(resource)
    end

    def serialized_data(resource, fieldset, collection)
      data =
        if collection
          serialized_collection(resource, fieldset)
        else
          serialized_hash(resource, fieldset)
        end

      { data: data }
    end

    def serialized_hash(resource, fieldset)
      return unless resource

      identifier_of(resource)
        .merge(attributes_from(resource, fieldset))
        .merge(relationships_from(resource, fieldset))
    end

    def serialized_collection(resource_collection, fieldset)
      Array(resource_collection)
        .map { |resource| serialized_hash(resource, fieldset) }
        .compact
    end

    def identifier_of(resource)
      identifier.serialize(resource)
    end

    def attributes_from(resource, fieldset)
      attribute_collection.serialize(resource, fieldset: fieldset)
    end

    def relationships_from(resource, fieldset)
      relationship_collection.serialize(resource, fieldset: fieldset)
    end

    def serialized_included(resource, fieldset, including, collection)
      included_collection = IncludedResourceCollection.build(including, relationship_collection)
      included_collection.serialize(resource, fieldset: fieldset, collection: collection)
    end
  end
end
