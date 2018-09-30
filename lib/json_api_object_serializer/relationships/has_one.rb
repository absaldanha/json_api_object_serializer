# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasOne < Base
      def serialize_data(resource)
        relationship = relationship_from(resource)

        { data: identifier.serialize(relationship) }
      end
    end
  end
end
