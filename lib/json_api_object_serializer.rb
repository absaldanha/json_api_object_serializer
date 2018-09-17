# frozen_string_literal: true

require "json_api_object_serializer/version"
require "json_api_object_serializer/serialized_name"
require "json_api_object_serializer/identifier"
require "json_api_object_serializer/attribute_collection"
require "json_api_object_serializer/relationship_collection"
require "json_api_object_serializer/relationships"
require "json_api_object_serializer/attribute"
require "json_api_object_serializer/dsl"
require "json_api_object_serializer/serialization"

module JsonApiObjectSerializer
  def self.included(base)
    base.class_eval do
      extend Serialization
    end
  end
end
