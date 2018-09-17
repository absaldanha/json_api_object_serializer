# frozen_string_literal: true

module JsonApiObjectSerializer
  class Attribute
    include SerializedName

    attr_reader :name, :options

    def initialize(name:, **options)
      @name = name
      @options = options
    end

    def serialize(resource)
      { serialized_name => resource.public_send(name) }
    end

    def eql?(other)
      name == other.name
    end

    def hash
      name.hash
    end
  end
end
