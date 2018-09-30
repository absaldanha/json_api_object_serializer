# frozen_string_literal: true

module JsonApiObjectSerializer
  module Links
    class Base
      include KeySerialization

      attr_reader :name, :block

      def initialize(name, &block)
        @name = name.to_sym
        @block = block

        post_initialize
      end

      def serialize(_resource); end

      def post_initialize; end
    end
  end
end
