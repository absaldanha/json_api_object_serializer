# frozen_string_literal: true

module JsonApiObjectSerializer
  module DSL
    def self.extended(base)
      base.class_eval do
        singleton_class.class_eval do
          attr_accessor :attribute_collection, :relationship_collection, :identifier, :meta_object
        end

        self.attribute_collection = AttributeCollection.new
        self.relationship_collection = RelationshipCollection.new
        self.identifier = Identifier.new
        self.meta_object = Meta.new
      end
    end

    def id(custom_id)
      identifier.id = custom_id
    end

    def type(type)
      identifier.type = type
    end

    def attribute(name, **options)
      attribute_collection.add(Attribute.new(name: name, **options))
    end

    def attributes(*names)
      names.each { |name| attribute(name) }
    end

    def has_one(name, type:, **options)
      relationship_collection.add(Relationships.has_one(name: name, type: type, **options))
    end

    def has_many(name, type:, **options)
      relationship_collection.add(Relationships.has_many(name: name, type: type, **options))
    end

    def meta(hash = {})
      meta_object.add(hash)
    end
  end
end
