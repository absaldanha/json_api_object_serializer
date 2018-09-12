# frozen_string_literal: true

require "json_api_object_serializer/relationships/base"
require "json_api_object_serializer/relationships/has_one"

module JsonApiObjectSerializer
  module Relationships
    def self.build(relationship_type, name:, type:)
      case relationship_type
      when :has_one
        HasOne.new(name: name, type: type)
      else
        Base.new(name: name, type: type)
      end
    end
  end
end
