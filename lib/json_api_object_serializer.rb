# frozen_string_literal: true

require "json_api_object_serializer/version"
require "json_api_object_serializer/core_ext"
require "json_api_object_serializer/key_serialization"
require "json_api_object_serializer/serialized_name"
require "json_api_object_serializer/meta"
require "json_api_object_serializer/null_fieldset"
require "json_api_object_serializer/fieldset"
require "json_api_object_serializer/identifier"
require "json_api_object_serializer/null_link_collection"
require "json_api_object_serializer/link_collection_builder"
require "json_api_object_serializer/link_collection"
require "json_api_object_serializer/links"
require "json_api_object_serializer/attribute_collection"
require "json_api_object_serializer/relationship_collection"
require "json_api_object_serializer/included_resource_collection"
require "json_api_object_serializer/relationships"
require "json_api_object_serializer/attribute"
require "json_api_object_serializer/included_resource"
require "json_api_object_serializer/dsl"
require "json_api_object_serializer/serialization"

module JsonApiObjectSerializer
  def self.included(base)
    base.class_eval do
      extend Serialization
    end
  end
end
