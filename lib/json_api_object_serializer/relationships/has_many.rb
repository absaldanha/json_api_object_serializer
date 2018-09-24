# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasMany < Base
      def serialize(resource)
        {
          serialized_name => {
            data: relationship_from(resource).map do |relationship|
              identifier.serialize(relationship)
            end
          }
        }
      end

      def fully_serialize_options
        { collection: true }
      end
    end
  end
end
