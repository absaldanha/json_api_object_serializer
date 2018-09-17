# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasMany < Base
      def serialize(resource)
        relationships = resource.public_send(name)

        {
          serialized_name => {
            data: relationships.map do |relationship|
              { type: type, id: relationship.id.to_s }
            end
          }
        }
      end
    end
  end
end
