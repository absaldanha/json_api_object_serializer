# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::IncludedResource do
  describe "#serialize" do
    context "when the serialization uses including resources" do
      it "retruns the fully serialized hash with its included resources" do
        resource = double(:resource)
        relationship = instance_double(
          JsonApiObjectSerializer::Relationships::Base,
          fully_serialize: {
            data: [
              { id: "1", type: "foos", attributes: { foo: "Foo" } },
              { id: "2", type: "foos", attributes: { foo: "Fus" } }
            ],
            included: [
              { id: "1", type: "bars", attributes: { bar: "Bar" } }
            ]
          }
        )

        included_resource = JsonApiObjectSerializer::IncludedResource.new(relationship, "bar")

        expect(included_resource.serialize(resource)).to contain_exactly(
          { id: "1", type: "foos", attributes: { foo: "Foo" } },
          { id: "2", type: "foos", attributes: { foo: "Fus" } },
          id: "1", type: "bars", attributes: { bar: "Bar" }
        )
      end
    end

    context "when the serialization doesn't include any other resource" do
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
end
