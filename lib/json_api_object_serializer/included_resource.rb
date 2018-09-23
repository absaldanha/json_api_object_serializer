# frozen_string_literal: true

module JsonApiObjectSerializer
  class IncludedResource
    attr_reader :relationship

    def initialize(relationship)
      @relationship = relationship
    end

    def serialize(resource, fieldset: NullFieldset.new)
      serialized_hash = relationship.fully_serialize(resource, fieldset: fieldset)
      serialized_hash.delete(:data)
    end
  end
end
