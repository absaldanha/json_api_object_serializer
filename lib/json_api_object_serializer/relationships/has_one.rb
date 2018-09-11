# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasOne < Base
      attr_reader :name, :type, :serialized_name

      def initialize(name:, type:)
        @name = name
        @type = type
        @serialized_name = name.to_s.tr("_", "-") .to_sym
      end

      def serialization_of(resource_object)
        relationship_object = resource_object.public_send(name)

        {
          serialized_name => {
            data: { id: relationship_object.id.to_s, type: type }
          }
        }
      end

      def eql?(other)
        name == other.name && serialized_name == other.serialized_name
      end

      def hash
        [name, serialized_name].hash
      end
    end
  end
end
