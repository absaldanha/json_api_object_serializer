# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class AttributeCollection
    extend Forwardable

    def_delegators :attributes, :add, :empty?

    def initialize
      @attributes = Set.new
    end

    def serialize(resource, fieldset: NullFieldset.new)
      return {} if empty?

      serialized_attributes = attributes_from(fieldset).inject({}) do |hash, attribute|
        hash.merge(attribute.serialize(resource))
      end

      serialized_attributes.empty? ? {} : { attributes: serialized_attributes }
    end

    private

    attr_reader :attributes

    def attributes_from(fieldset)
      attributes.select { |attribute| fieldset.include?(attribute.serialized_name) }
    end
  end
end
