# frozen_string_literal: true

module JsonApiObjectSerializer
  class NullFieldset
    def include?(_field)
      true
    end

    def all_fields
      {}
    end
  end
end
