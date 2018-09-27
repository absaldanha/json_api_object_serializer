# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::CoreExt::Hashes do
  using JsonApiObjectSerializer::CoreExt::Hashes

  describe "#deep_transform_keys" do
    it "transform keys on shallow hashes" do
      hash = { "a" => 1, "b" => 2 }

      expect(hash.deep_transform_keys(&:to_sym)).to eq(a: 1, b: 2)
    end

    it "transform keys on hashes within other hashes" do
      hash = { a: 1, b: { c: 2 } }
      result = hash.deep_transform_keys { |key| "#{key}-foo" }

      expect(result).to eq("a-foo" => 1, "b-foo" => { "c-foo" => 2 })
    end

    it "transform keys on hashes within arrays" do
      hash = { "a" => 1, b: { "c" => [{ d: 3 }, { "e" => 4 }] } }
      result = hash.deep_transform_keys(&:to_sym)

      expect(result).to eq(a: 1, b: { c: [{ d: 3 }, { e: 4 }] })
    end
  end
end
