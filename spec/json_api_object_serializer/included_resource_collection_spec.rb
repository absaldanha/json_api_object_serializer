# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::IncludedResourceCollection do
  describe ".build" do
    it "builds a new collection correctly" do
      relationship_collection = instance_double(JsonApiObjectSerializer::RelationshipCollection)
      allow(relationship_collection)
        .to receive(:find_by_serialized_name)
        .twice.and_return(double(:relationship1), double(:relationship2))

      collection = JsonApiObjectSerializer::IncludedResourceCollection.build(
        %i[foo bar.baz], relationship_collection
      )

      aggregate_failures do
        expect(collection).to be_an_instance_of JsonApiObjectSerializer::IncludedResourceCollection
        expect(collection.size).to eq 2
      end
    end
  end

  describe "#serialize" do
    context "when the collection is empty" do
      subject(:included_collection) { JsonApiObjectSerializer::IncludedResourceCollection.new }

      it "returns an empty hash" do
        resource = double(:resource)

        expect(included_collection.serialize(resource)).to eq({})
      end
    end

    context "when the collection is not empty" do
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

      it "returns the serialized hash of the collection" do
        resource = double(:resource)

        expect(included_resource_collection.serialize(resource)).to eq(
          included: [
            { id: "1", type: "foos", attributes: { foo: "Foo" } },
            { id: "1", type: "bars", attributes: { bar: "Bar 1" } },
            { id: "2", type: "bars", attributes: { bar: "Bar 2" } }
          ]
        )
      end
    end
  end
end
