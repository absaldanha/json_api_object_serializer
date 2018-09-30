# frozen_string_literal: true

require "json_api_object_serializer/links/base"
require "json_api_object_serializer/links/simple"
require "json_api_object_serializer/links/compound"

module JsonApiObjectSerializer
  module Links
    def self.simple(name, &blk)
      Simple.new(name, &blk)
    end

    def self.compound(name, &blk)
      Compound.new(name, &blk)
    end
  end
end
