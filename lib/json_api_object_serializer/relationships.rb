# frozen_string_literal: true

require "json_api_object_serializer/relationships/base"
require "json_api_object_serializer/relationships/has_one"
require "json_api_object_serializer/relationships/has_many"

module JsonApiObjectSerializer
  module Relationships
    def self.has_one(name:, type:, **options, &block)
      HasOne.new(name: name, type: type, **options, &block)
    end

    def self.has_many(name:, type:, **options, &block)
      HasMany.new(name: name, type: type, **options, &block)
    end
  end
end
