# frozen_string_literal: true

module JsonApiObjectSerializer
  class Attribute
    attr_reader :name, :serialized_name

    def initialize(name:)
      @name = name
      @serialized_name = name.to_s.tr("_", "-") .to_sym
    end

    def eql?(other)
      name == other.name && serialized_name == other.serialized_name
    end

    def hash
      [name, serialized_name].hash
    end
  end
end
