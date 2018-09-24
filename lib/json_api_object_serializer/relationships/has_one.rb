# frozen_string_literal: true

module JsonApiObjectSerializer
  module Relationships
    class HasOne < Base
      def serialize(resource)
        relationship = relationship_from(resource)

        { serialized_name => { data: identifier.serialize(relationship) } }
      end
    end
  end
end
