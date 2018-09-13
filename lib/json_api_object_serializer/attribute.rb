# frozen_string_literal: true

module JsonApiObjectSerializer
  class Attribute
    include NameFormating

    attr_reader :name, :serialized_name

    def initialize(name:, **options)
      @name = name
      @serialized_name = name_formating_of(options[:as] || name).to_sym
    end

    def eql?(other)
      name == other.name
    end

    def hash
      name.hash
    end
  end
end
