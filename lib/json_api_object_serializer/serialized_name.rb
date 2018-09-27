# frozen_string_literal: true

module JsonApiObjectSerializer
  module SerializedName
    include KeySerialization

    def serialized_name
      @serialized_name ||= serialized_key(options[:as] || name)
    end
  end
end
