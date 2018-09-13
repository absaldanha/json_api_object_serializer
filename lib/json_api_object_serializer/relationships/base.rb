# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class Base
      include SerializedName

      attr_reader :name, :type, :options

      def initialize(name:, type:, **options)
        @name = name
        @type = type
        @options = options
      end

      def serialization_of(_resource); end

      def eql?(other)
        name == other.name
      end

      def hash
        name.hash
      end
    end
  end
end
