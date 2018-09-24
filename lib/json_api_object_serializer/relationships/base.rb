# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class Base
      include SerializedName

      attr_reader :name, :type, :identifier, :options

      def initialize(name:, type:, **options)
        @name = name
        @type = type
        @identifier = Identifier.new(type: type)
        @options = options
      end

      def serialize(_resource); end

      def fully_serialize(resource, fieldset: NullFieldset.new)
        relationship = relationship_from(resource)
        serializer.to_hash(relationship, fully_serialize_options.merge(fields: fieldset.all_fields))
      end

      def relationship_from(resource)
        resource.public_send(name)
      end

      def serializer
        @serializer ||= options[:serializer]
      end

      def fully_serialize_options
        {}
      end

      def eql?(other)
        name == other.name
      end

      def hash
        name.hash
      end
    end
  end
end
