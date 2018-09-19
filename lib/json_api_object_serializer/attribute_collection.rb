# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class AttributeCollection
    extend Forwardable

    def_delegators :attributes, :size, :include?

    def initialize
      @attributes = Set.new
    end

    def add(attribute)
      attributes.add(attribute)
    end

    def serialize(resource, fieldset: NullFieldset.new)
      attributes_from(fieldset).inject({}) do |hash, attribute|
        hash.merge(attribute.serialize(resource))
      end
    end

    private

    attr_reader :attributes

    def attributes_from(fieldset)
      attributes.select { |attribute| fieldset.include?(attribute.serialized_name) }
    end
  end
end
