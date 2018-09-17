# frozen_string_literal: true

module JsonApiObjectSerializer
  class Identifier
    attr_reader :id, :type

    def initialize
      @id = proc { |resource| resource.id }
      @type = nil
    end

    def serialize(resource_object)
      { id: id.call(resource_object).to_s, type: type }
    end

    def type=(type)
      @type = type.to_s
    end

    def id=(custom_id)
      @id = custom_id.to_proc
    end
  end
end
