# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class Fieldset
    extend Forwardable

    attr_reader :fields, :type, :all_fields
    def_delegators :fields, :include?

    def self.build(type, fields = {})
      type_fields = fields[type.to_sym]

      type_fields.nil? ? NullFieldset.new : new(type_fields, type, fields)
    end

    def initialize(fields, type, all_fields)
      @type = type
      @fields = Set.new(fields)
      @all_fields = all_fields
    end
  end
end
