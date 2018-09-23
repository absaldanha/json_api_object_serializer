# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::IncludedResource do
  describe "#serialize" do
    it "returns the fully serialized hash of the resource relationship" do
      resource = double(:resource)
      relationship = instance_double(
        JsonApiObjectSerializer::Relationships::Base,
        fully_serialize: {
          data: {
            id: "1", type: "foos", attributes: { foo: "Foo", bar: "Bar" },
            relationships: { bar: { data: { id: "1", type: "bars" } } }
          }
        }
      )
      included_resource = JsonApiObjectSerializer::IncludedResource.new(relationship)

      expect(included_resource.serialize(resource)).to eq(
        id: "1", type: "foos", attributes: { foo: "Foo", bar: "Bar" },
        relationships: { bar: { data: { id: "1", type: "bars" } } }
      )
    end
  end
end
