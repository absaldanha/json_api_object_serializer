# frozen_string_literal: true

module JsonApiObjectSerializer
  class IncludedResource
    attr_reader :relationship, :includings

    def initialize(relationship, deep_including = nil)
      @relationship = relationship
      @includings = deep_including.nil? ? [] : [deep_including.to_sym]
    end

    def serialize(resource, fieldset: NullFieldset.new)
      serialized_hash =
        relationship.fully_serialize(resource, fieldset: fieldset, including: includings)

      if serialized_hash.key?(:included)
        [serialized_hash[:data], serialized_hash[:included]].flatten
      else
        serialized_hash[:data]
      end
    end
  end
end
