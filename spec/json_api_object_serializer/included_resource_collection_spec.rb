# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::IncludedResourceCollection do
  describe "#serialize" do
    let(:included_resource1) do
      instance_double(
        JsonApiObjectSerializer::IncludedResource,
        serialize: {
          id: "1", type: "foos", attributes: { foo: "Foo" }
        }
      )
    end

    let(:included_resource2) do
      instance_double(
        JsonApiObjectSerializer::IncludedResource,
        serialize: [
          { id: "1", type: "bars", attributes: { bar: "Bar 1" } },
          { id: "2", type: "bars", attributes: { bar: "Bar 2" } }
        ]
      )
    end

    subject(:included_resource_collection) do
      JsonApiObjectSerializer::IncludedResourceCollection.new
    end

    before do
      included_resource_collection.add(included_resource1)
      included_resource_collection.add(included_resource2)
    end

    it "returns an array with the serialized included resources" do
      resource = double(:resource)

      expect(included_resource_collection.serialize(resource)).to contain_exactly(
        { id: "1", type: "foos", attributes: { foo: "Foo" } },
        { id: "1", type: "bars", attributes: { bar: "Bar 1" } },
        id: "2", type: "bars", attributes: { bar: "Bar 2" }
      )
    end
  end
end
