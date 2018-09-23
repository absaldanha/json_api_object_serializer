# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::AttributeCollection do
  subject(:attribute_collection) { JsonApiObjectSerializer::AttributeCollection.new }

  describe "#serialize" do
    context "with no field restriction" do
      it "returns the serialized hash of all attributes of the given resource object" do
        resource = double(:resource)
        first_name_attribute = instance_double(
          JsonApiObjectSerializer::Attribute,
          serialized_name: :"first-name",
          serialize: { "first-name": "Alexandre" }
        )
        last_name_attribute = instance_double(
          JsonApiObjectSerializer::Attribute,
          serialized_name: :"last-name",
          serialize: { "last-name": "Saldanha" }
        )

        attribute_collection.add(first_name_attribute)
        attribute_collection.add(last_name_attribute)

        expect(attribute_collection.serialize(resource)).to match(
          "first-name": "Alexandre", "last-name": "Saldanha"
        )
      end
    end

    context "with field restriction" do
      it "returns the serialized hash of the specified attributes of the given resource object" do
        resource = double(:resource)
        fieldset = instance_double(JsonApiObjectSerializer::Fieldset)
        first_name_attribute = instance_double(
          JsonApiObjectSerializer::Attribute,
          serialize: { "first-name": "Alexandre" },
          serialized_name: :"first-name"
        )
        last_name_attribute = instance_double(
          JsonApiObjectSerializer::Attribute,
          serialized_name: :"last-name"
        )

        allow(fieldset).to receive(:include?).with(:"first-name").and_return(true)
        allow(fieldset).to receive(:include?).with(:"last-name").and_return(false)

        attribute_collection.add(first_name_attribute)
        attribute_collection.add(last_name_attribute)

        expect(attribute_collection.serialize(resource, fieldset: fieldset)).to match(
          "first-name": "Alexandre"
        )
      end
    end
  end
end
