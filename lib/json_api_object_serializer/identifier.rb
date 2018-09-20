# frozen_string_literal: true

module JsonApiObjectSerializer
  class Identifier
    attr_reader :id, :type

    def initialize(id: nil, type: nil)
      @id = callable_id(id) || proc { |resource| resource.id }
      @type = type
    end

    def serialize(resource_object)
      { id: id.call(resource_object).to_s, type: type }
    end

    def type=(type)
      @type = type.to_s
    end

    def id=(custom_id)
      @id = callable_id(custom_id)
    end

    private

    def callable_id(id)
      return unless id

      id.to_proc
    end
  end
end
