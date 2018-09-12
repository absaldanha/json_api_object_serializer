# frozen_string_literal: true

module JsonApiObjectSerializer
  module DSL
    def self.extended(base)
      base.class_eval do
        @attribute_collection = AttributeCollection.new
        @relationship_collection = RelationshipCollection.new
        @type = nil
      end
    end

    def type(type)
      @type = type.to_s
    end

    def attribute(name)
      @attribute_collection.add(Attribute.new(name: name))
    end

    def attributes(*names)
      names.each { |name| attribute(name) }
    end

    def has_one(name, type:)
      @relationship_collection.add(Relationships.build(:has_one, name: name, type: type))
    end
  end
end
