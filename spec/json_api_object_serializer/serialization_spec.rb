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
        attr_writer :type, :attribute_collection
      end

      include JsonApiObjectSerializer::Serialization
    end
  end

  describe "#to_hash" do
    before do
      dummy_serializer_class.type = "dummies"
      dummy_serializer_class.attribute_collection = attribute_collection
    end

    subject(:dummy_serializer_object) { dummy_serializer_class.new }

    it "returns the serialized hash of the given resource object" do
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
end
