# frozen_string_literal: true

module JsonApiObjectSerializer
  module SerializedName
    def serialized_name
      @serialized_name ||= name_formating(options[:as] || name).to_sym
    end

    private

    def name_formating(string)
      string.to_s.tr("_", "-")
    end
  end
end
