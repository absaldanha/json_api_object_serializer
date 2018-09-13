# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class Base
      include NameFormating

      attr_reader :name, :type, :serialized_name

      def initialize(name:, type:, **options)
        @name = name
        @type = type
        @serialized_name = name_formating_of(options[:as] || name).to_sym
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
