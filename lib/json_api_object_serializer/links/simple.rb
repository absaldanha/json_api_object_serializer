# frozen_string_literal: true

module JsonApiObjectSerializer
  module Links
    class Simple < Base
      def serialize(resource)
        { serialized_key(name) => block.call(resource) }
      end
    end
  end
end
