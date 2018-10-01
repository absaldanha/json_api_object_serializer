# frozen_string_literal: true

module JsonApiObjectSerializer
  module Links
    class Compound < Base
      attr_reader :href_link, :meta_blk

      def post_initialize
        instance_eval(&block)
      end

      def serialize(resource)
        compound_name = serialized_key(name)

        {}.tap do |hash|
          hash[compound_name] = href_link.serialize(resource)
          hash[compound_name].merge!(serialized_meta(resource))
        end
      end

      private

      def href(&blk)
        @href_link = Links.simple(:href, &blk)
      end

      def meta(&blk)
        @meta_blk = blk
      end

      def serialized_meta(resource)
        meta_hash = meta_blk.call(resource)
        Meta.new(meta_hash).serialize
      end
    end
  end
end
