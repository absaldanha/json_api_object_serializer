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

    def attribute(name, **options)
      @attribute_collection.add(Attribute.new(name: name, **options))
    end

    def attributes(*names)
      names.each { |name| attribute(name) }
    end

    def has_one(name, type:, **options)
      @relationship_collection.add(Relationships.has_one(name: name, type: type, **options))
    end

    def has_many(name, type:, **options)
      @relationship_collection.add(Relationships.has_many(name: name, type: type, **options))
    end
  end
end
