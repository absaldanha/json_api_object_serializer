# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::LinkCollection do
  describe "#serialize" do
    let(:link1) do
      instance_double(
        JsonApiObjectSerializer::Links::Base,
        serialize: { foo: "foo_link" }
      )
    end

    let(:link2) do
      instance_double(
        JsonApiObjectSerializer::Links::Base,
        serialize: { bar: { href: "bar_link", meta: { meta_key: "meta_value" } } }
      )
    end

    subject(:link_collection) { JsonApiObjectSerializer::LinkCollection.new }

    before do
      link_collection.add(link1)
      link_collection.add(link2)
    end

    it "returns the serialized hash of the link collection" do
      resource = double(:resource)

      expect(link_collection.serialize(resource)).to eq(
        foo: "foo_link",
        bar: {
          href: "bar_link",
          meta: { meta_key: "meta_value" }
        }
      )
    end
  end
end
