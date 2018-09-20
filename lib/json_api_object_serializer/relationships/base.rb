# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class Base
      include SerializedName

      attr_reader :name, :type, :identifier, :options

      def initialize(name:, type:, **options)
        @name = name
        @type = type
        @identifier = Identifier.new(id: options[:id], type: type)
        @options = options
      end

      def serialize(_resource); end

      def eql?(other)
        name == other.name
      end

      def hash
        name.hash
      end
    end
  end
end
