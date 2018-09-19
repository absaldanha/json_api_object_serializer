# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class Fieldset
    extend Forwardable

    attr_reader :fields, :type
    def_delegators :fields, :include?

    def self.build(type, fields = {})
      type_fields = fields[type.to_sym]

      type_fields.nil? ? NullFieldset.new : new(type_fields, type)
    end

    def initialize(fields, type)
      @type = type
      @fields = Set.new(fields)
    end
  end
end
