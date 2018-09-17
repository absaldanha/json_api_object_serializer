# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasOne < Base
      def serialize(resource)
        relationship = resource.public_send(name)

        {
          serialized_name => {
            data: { id: relationship.id.to_s, type: type }
          }
        }
      end
    end
  end
end
