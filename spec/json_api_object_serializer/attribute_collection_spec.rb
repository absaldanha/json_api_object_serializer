# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::AttributeCollection do
  subject(:attribute_collection) { JsonApiObjectSerializer::AttributeCollection.new }

  describe "#serialize" do
    context "when collection is empty" do
      it "returns an empty hash" do
        resource = double(:resource)

        expect(attribute_collection.serialize(resource)).to eq({})
      end
    end

    context "when collection is not empty" do
      context "and some field restriction is applied" do
        let(:first_name_attribute) do
          instance_double(
            JsonApiObjectSerializer::Attribute,
            serialized_name: :"first-name",
            serialize: { "first-name": "Alexandre" }
          )
        end

        let(:last_name_attribute) do
          instance_double(
            JsonApiObjectSerializer::Attribute,
            serialized_name: :"last-name"
          )
        end

        before do
          attribute_collection.add(first_name_attribute)
          attribute_collection.add(last_name_attribute)
        end

        it "returns the serialized hash of only the permitted attributes of the given resource" do
          resource = double(:resource)
          fieldset = instance_double(JsonApiObjectSerializer::Fieldset)

          allow(fieldset).to receive(:include?).with(:"first-name").and_return(true)
          allow(fieldset).to receive(:include?).with(:"last-name").and_return(false)

          expect(attribute_collection.serialize(resource, fieldset: fieldset)).to eq(
            attributes: { "first-name": "Alexandre" }
          )
        end
      end

      context "and field restriction is applied to all attributes" do
        let(:first_name_attribute) do
          instance_double(
            JsonApiObjectSerializer::Attribute,
            serialized_name: :"first-name"
          )
        end

        let(:last_name_attribute) do
          instance_double(
            JsonApiObjectSerializer::Attribute,
            serialized_name: :"last-name"
          )
        end

        before do
          attribute_collection.add(first_name_attribute)
          attribute_collection.add(last_name_attribute)
        end

        it "returns an empty hash" do
          resource = double(:resource)
          fieldset = instance_double(JsonApiObjectSerializer::Fieldset, include?: false)

          expect(attribute_collection.serialize(resource, fieldset: fieldset)).to eq({})
        end
      end
    end
  end
end
