# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasMany < Base
      def serialization_of(resource_object)
        relationship_array = resource_object.public_send(name)

        {
          serialized_name => {
            data: relationship_array.map { |relationship| { type: type, id: relationship.id.to_s } }
          }
        }
      end
    end
  end
end
