# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasOne < Base
      def serialization_of(resource_object)
        relationship_object = resource_object.public_send(name)

        {
          serialized_name => {
            data: { id: relationship_object.id.to_s, type: type }
          }
        }
      end
    end
  end
end
