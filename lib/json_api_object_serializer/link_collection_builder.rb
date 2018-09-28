# frozen_string_literal: true

module JsonApiObjectSerializer
  class LinkCollectionBuilder
    attr_reader :link_collection

    def self.build(&block)
      new.build(&block)
    end

    def initialize
      @link_collection = LinkCollection.new
    end

    def build(&block)
      instance_eval(&block)
      link_collection
    end

    private

    def simple(name, &block)
      link_collection.add(Links.simple(name, &block))
    end

    def compound(name, &block)
      link_collection.add(Links.compound(name, &block))
    end
  end
end
