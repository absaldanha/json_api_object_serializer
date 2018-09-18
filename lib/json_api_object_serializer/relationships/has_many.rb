# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasMany < Base
      def serialize(resource)
        relationships = resource.public_send(name)

        {
          serialized_name => {
            data: relationships.map do |relationship|
              identifier.serialize(relationship)
            end
          }
        }
      end
    end
  end
end
