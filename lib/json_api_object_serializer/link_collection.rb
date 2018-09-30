# frozen_string_literal: true

require "set"
require "forwardable"

module JsonApiObjectSerializer
  class LinkCollection
    extend Forwardable

    def_delegators :links, :add, :size, :empty?

    def initialize
      @links = Set.new
    end

    def serialize(resource)
      links_hash = links.inject({}) do |hash, link|
        hash.merge(link.serialize(resource))
      end

      { links: links_hash }
    end

    private

    attr_reader :links
  end
end
