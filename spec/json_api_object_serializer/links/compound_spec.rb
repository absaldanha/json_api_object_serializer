# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Links::Compound do
  describe "#serialize" do
    subject(:link) do
      JsonApiObjectSerializer::Links::Compound.new(:foo) do
        href { |resource| "foos/#{resource.id}" }
        meta { |_resource| { meta_key: "meta_value" } }
      end
    end

    it "serializes the link correctly" do
      resource = double(:resource, id: "foo-id")

      expect(link.serialize(resource)).to eq(
        foo: {
          href: "foos/foo-id",
          meta: { "meta-key": "meta_value" }
        }
      )
    end
  end
end
