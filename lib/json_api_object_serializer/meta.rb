# frozen_string_literal: true

require "forwardable"

module JsonApiObjectSerializer
  class Meta
    include KeySerialization
    extend Forwardable
    using CoreExt::Hashes

    def_delegators :hash, :empty?

    attr_reader :hash

    def initialize(hash = {})
      @hash = hash
    end

    def serialize
      hash.deep_transform_keys { |key| serialized_key(key) }
    end

    def add(other_hash = {})
      hash.merge!(other_hash)
    end
  end
end
