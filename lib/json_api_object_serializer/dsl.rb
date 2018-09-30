# frozen_string_literal: true

module JsonApiObjectSerializer
  module DSL
    # rubocop:disable Metrics/MethodLength
    def self.extended(base)
      base.class_eval do
        singleton_class.class_eval do
          attr_accessor :attribute_collection, :relationship_collection, :identifier, :meta_object,
                        :link_collection
        end

        self.attribute_collection = AttributeCollection.new
        self.relationship_collection = RelationshipCollection.new
        self.identifier = Identifier.new
        self.meta_object = Meta.new
        self.link_collection = NullLinkCollection.new
      end
    end
    # rubocop:enable Metrics/MethodLength

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

    def has_one(name, type:, **options, &block)
      relationship_collection.add(Relationships.has_one(name: name, type: type, **options, &block))
    end

    def has_many(name, type:, **options, &block)
      relationship_collection.add(Relationships.has_many(name: name, type: type, **options, &block))
    end

    def meta(hash = {})
      meta_object.add(hash)
    end

    def links(&blk)
      self.link_collection = LinkCollectionBuilder.build(&blk)
    end
  end
end
