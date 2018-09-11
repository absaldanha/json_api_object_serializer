# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Serialization do
  include DummyObject

  let(:attribute_collection) do
    instance_double(
      JsonApiObjectSerializer::AttributeCollection,
      serialized_attributes_of: { foo: "foo", bar: "bar" }
    )
  end

  let(:dummy_serializer_class) do
    Class.new do
      class << self
        attr_writer :type, :attribute_collection, :relationship_collection
      end

      include JsonApiObjectSerializer::Serialization
    end
  end

  subject(:dummy_serializer_object) { dummy_serializer_class.new }

  describe "#to_hash" do
    before do
      dummy_serializer_class.type = "dummies"
      dummy_serializer_class.attribute_collection = attribute_collection
    end

    context "without relationships" do
      let(:relationship_collection) do
        instance_double(JsonApiObjectSerializer::RelationshipCollection, empty?: true)
      end

      before do
        dummy_serializer_class.relationship_collection = relationship_collection
      end

      it "returns the serialized hash of the given resource object without any relationship" do
        dummy_object = dummy_object(id: 1)

        expect(dummy_serializer_object.to_hash(dummy_object)).to match(
          data: {
            id: "1",
            type: "dummies",
            attributes: { foo: "foo", bar: "bar" }
          }
        )
      end
    end

    context "with relationships" do
      let(:relationship_collection) do
        instance_double(
          JsonApiObjectSerializer::RelationshipCollection,
          empty?: false,
          serialized_relationships_of: {
            address: { data: { id: "address_id", type: "addresses" } },
            tasks: {
              data: [
                { id: "task_id_1", type: "tasks" }, { id: "tasks_id_2", type: "tasks" }
              ]
            }
          }
        )
      end

      before do
        dummy_serializer_class.relationship_collection = relationship_collection
      end

      it "returns the serialized hash of the given resource object with their relationships" do
        dummy = dummy_object(id: 123)

        expect(dummy_serializer_object.to_hash(dummy)).to match(
          data: {
            id: "123",
            type: "dummies",
            attributes: { foo: "foo", bar: "bar" },
            relationships: {
              address: { data: { id: "address_id", type: "addresses" } },
              tasks: {
                data: [
                  { id: "task_id_1", type: "tasks" }, { id: "tasks_id_2", type: "tasks" }
                ]
              }
            }
          }
        )
      end
    end
  end
end
