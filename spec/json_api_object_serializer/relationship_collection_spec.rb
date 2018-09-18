# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::RelationshipCollection do
  subject(:relationship_collection) { JsonApiObjectSerializer::RelationshipCollection.new }

  describe "#add" do
    it "adds a new relationship" do
      relationship = JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo, type: "foos")

      relationship_collection.add(relationship)

      expect(relationship_collection).to include relationship
    end

    it "doesn't add a repeated relationship" do
      original_relationship =
        JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo, type: "foos")
      repeated_relationship =
        JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo, type: "foos")

      relationship_collection.add(original_relationship)
      relationship_collection.add(repeated_relationship)

      expect(relationship_collection.size).to eq 1
      expect(relationship_collection).to include original_relationship
    end
  end

  describe "#serialize" do
    it "returns the serialized hash of relationships of the given resource object" do
      resource = double(:resource)
      address_relationship = instance_double(
        JsonApiObjectSerializer::Relationships::Base,
        serialize: { address: { data: { id: "address_id", type: "addresses" } } }
      )
      tasks_relationship = instance_double(
        JsonApiObjectSerializer::Relationships::Base,
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
end
