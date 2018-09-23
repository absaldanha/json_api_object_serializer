# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::RelationshipCollection do
  subject(:relationship_collection) { JsonApiObjectSerializer::RelationshipCollection.new }

  describe "#serialize" do
    context "with no field restrictions" do
      it "returns the serialized hash of all relationships of the given resource object" do
        resource = double(:resource)
        address_relationship = instance_double(
          JsonApiObjectSerializer::Relationships::Base,
          serialized_name: :address,
          serialize: { address: { data: { id: "address_id", type: "addresses" } } }
        )
        tasks_relationship = instance_double(
          JsonApiObjectSerializer::Relationships::Base,
          serialized_name: :tasks,
          serialize: { tasks: { data: [
            { id: "task_id_1", type: "tasks" }, { id: "task_id_2", type: "tasks" }
          ] } }
        )

        relationship_collection.add(address_relationship)
        relationship_collection.add(tasks_relationship)

        expect(relationship_collection.serialize(resource)).to eq(
          address: { data: { id: "address_id", type: "addresses" } },
          tasks: {
            data: [
              { id: "task_id_1", type: "tasks" }, { id: "task_id_2", type: "tasks" }
            ]
          }
        )
      end
    end

    context "with field restrictions" do
      it "returns the serialized hash of specified relationships of the given resource object" do
        resource = double(:resource)
        fieldset = instance_double(JsonApiObjectSerializer::Fieldset)
        address_relationship = instance_double(
          JsonApiObjectSerializer::Relationships::Base,
          serialize: { address: { data: { id: "address_id", type: "addresses" } } },
          serialized_name: :address
        )
        tasks_relationship = instance_double(
          JsonApiObjectSerializer::Relationships::Base,
          serialized_name: :tasks
        )

        allow(fieldset).to receive(:include?).with(:address).and_return(true)
        allow(fieldset).to receive(:include?).with(:tasks).and_return(false)

        relationship_collection.add(address_relationship)
        relationship_collection.add(tasks_relationship)

        expect(relationship_collection.serialize(resource, fieldset: fieldset)).to eq(
          address: { data: { id: "address_id", type: "addresses" } }
        )
      end
    end
  end

  describe "#find_by_serialized_name" do
    let(:relationship) do
      instance_double(JsonApiObjectSerializer::Relationships::Base, serialized_name: :foo)
    end

    before do
      relationship_collection.add(relationship)
    end

    context "when the relationship exists" do
      it "returns the correct relationship" do
        expect(relationship_collection.find_by_serialized_name(:foo)).to eq relationship
      end
    end

    context "when the relationship doesn't exist" do
      it "returns nil" do
        expect(relationship_collection.find_by_serialized_name(:bar)).to be nil
      end
    end
  end
end
