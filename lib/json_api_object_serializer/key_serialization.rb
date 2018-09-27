# frozen_string_literal: true

module JsonApiObjectSerializer
  module KeySerialization
    def serialized_key(key)
      key.to_s.tr("_", "-").to_sym
    end
  end
end
