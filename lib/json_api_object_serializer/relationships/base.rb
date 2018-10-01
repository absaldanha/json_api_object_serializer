# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class Base
      include SerializedName

      attr_reader :name, :type, :identifier, :options

      def initialize(name:, type:, **options, &block)
        @name = name
        @type = type
        @identifier = Identifier.new(type: type)
        @options = options

        instance_eval(&block) if block_given?
      end

      def serialize(resource)
        { serialized_name => serialize_data(resource).merge(serialize_links(resource)) }
      end

      def fully_serialize(resource, fieldset: NullFieldset.new, including: [])
        relationship = relationship_from(resource)

        serializer.to_hash(
          relationship,
          fully_serialize_options.merge(fields: fieldset.all_fields, include: including)
        )
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

      def serialize_data(_resource); end

      def eql?(other)
        name == other.name
      end

      def hash
        name.hash
      end

      def link_collection
        @link_collection ||= NullLinkCollection.new
      end

      private

      def links(&block)
        @link_collection = LinkCollectionBuilder.build(&block)
      end

      def serialize_links(resource)
        link_collection.serialize(resource)
      end
    end
  end
end
