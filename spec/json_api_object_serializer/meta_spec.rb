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
    context "when it is empty" do
      it "returns an empty hash" do
        expect(meta.serialize).to eq({})
      end
    end

    context "when it is not empty" do
      before do
        meta.add(foo: "foo", fuz_bar: "fuz-bar", bar: { "fuz" => "fuz" })
      end

      it "returns the serialized inner hash" do
        expect(meta.serialize).to eq(
          meta: { foo: "foo", "fuz-bar": "fuz-bar", bar: { fuz: "fuz" } }
        )
      end
    end
  end
end
