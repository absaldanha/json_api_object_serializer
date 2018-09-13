# frozen_string_literal: true

module JsonApiObjectSerializer
  module NameFormating
    def name_formating_of(string)
      string.to_s.tr("_", "-")
    end
  end
end
