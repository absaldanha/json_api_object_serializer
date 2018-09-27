# frozen_string_literal: true

module JsonApiObjectSerializer
  module CoreExt
    module Hashes
      refine Hash do
        def deep_transform_keys(&blk)
          each_with_object({}) do |(key, value), output|
            output[yield(key)] =
              case value
              when Hash then value.deep_transform_keys(&blk)
              when Array
                value.map { |item| item.is_a?(Hash) ? item.deep_transform_keys(&blk) : item }
              else
                value
              end
          end
        end
      end
    end
  end
end
