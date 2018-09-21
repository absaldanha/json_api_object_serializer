# frozen_string_literal: true

module JsonApiObjectSerializer
  class NullFieldset
    def include?(_field)
      true
    end
  end
end
