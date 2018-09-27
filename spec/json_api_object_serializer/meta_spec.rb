# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Meta do
  subject(:meta) { JsonApiObjectSerializer::Meta.new }

  describe "#add" do
    it "adds the contents of the hash in the meta object" do
      meta.add(foo: "foo", bar: "bar")

      expect(meta.hash).to eq(foo: "foo", bar: "bar")
    end
  end

  describe "#serialize" do
    it "returns the serialized inner hash" do
      meta.add(foo: "foo", fuz_bar: "fuz-bar", bar: { "fuz" => "fuz" })
      expect(meta.serialize).to eq(foo: "foo", "fuz-bar": "fuz-bar", bar: { fuz: "fuz" })
    end
  end
end
