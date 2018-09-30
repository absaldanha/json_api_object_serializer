# frozen_string_literal: true

module JsonApiObjectSerializer
  class NullLinkCollection
    def empty?
      true
    end

    def serialize(_resource)
      {}
    end
  end
end
