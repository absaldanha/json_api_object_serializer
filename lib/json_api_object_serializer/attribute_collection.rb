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

    def serialize(resource)
      attributes.inject({}) do |hash, attribute|
        hash.merge(attribute.serialize(resource))
      end
    end

    private

    attr_reader :attributes
  end
end
