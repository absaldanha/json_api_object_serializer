# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::AttributeCollection do
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

  describe "#serialized" do
    it "returns the serialized hash of attributes of the given resource object" do
      resource = double(:resource)
      first_name_attribute = instance_double(
        JsonApiObjectSerializer::Attribute, serialize: { "first-name": "Alexandre" }
      )
      last_name_attribute = instance_double(
        JsonApiObjectSerializer::Attribute,
        serialize: { "last-name": "Saldanha" }
      )

      attribute_collection.add(first_name_attribute)
      attribute_collection.add(last_name_attribute)

      expect(attribute_collection.serialize(resource)).to match(
        "first-name": "Alexandre", "last-name": "Saldanha"
      )
    end
  end
end
