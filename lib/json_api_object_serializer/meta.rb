# frozen_string_literal: true

require "forwardable"

module JsonApiObjectSerializer
  class Meta
    include KeySerialization
    using CoreExt::Hashes
    extend Forwardable

    def_delegators :hash, :empty?

    attr_reader :hash

    def initialize
      @hash = {}
    end

    def serialize
      hash.deep_transform_keys { |key| serialized_key(key) }
    end

    def add(other_hash = {})
      hash.merge!(other_hash)
    end
  end
end
