# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::AttributeCollection do
  include DummyObject

  subject(:attribute_collection) { JsonApiObjectSerializer::AttributeCollection.new }

  describe "#add" do
    it "adds a new Attribute" do
      attribute = JsonApiObjectSerializer::Attribute.new(name: :foo)

      attribute_collection.add(attribute)

      expect(attribute_collection).to include attribute
    end

    it "doesn't add a repeated Attribute" do
      original_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo)
      repeated_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo)

      attribute_collection.add(original_attribute)
      attribute_collection.add(repeated_attribute)

      expect(attribute_collection.size).to eq 1
      expect(attribute_collection).to include original_attribute
    end
  end

  describe "#serialized_attributes_of" do
    it "returns the serialized hash of attributes of the given resource object" do
      dummy = dummy_object(attributes: { first_name: "Alexandre", last_name: "Saldanha" })
      attribute_collection.add(JsonApiObjectSerializer::Attribute.new(name: :first_name))
      attribute_collection.add(JsonApiObjectSerializer::Attribute.new(name: :last_name))

      expect(attribute_collection.serialized_attributes_of(dummy)).to match(
        "first-name": "Alexandre", "last-name": "Saldanha"
      )
    end
  end
end
