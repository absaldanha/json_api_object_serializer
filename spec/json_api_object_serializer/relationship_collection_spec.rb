# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::RelationshipCollection do
  subject(:relationship_collection) { JsonApiObjectSerializer::RelationshipCollection.new }

  describe "#serialize" do
    context "when collection is empty" do
      it "returns an empty hash" do
        resource = double(:resource)

        expect(relationship_collection.serialize(resource)).to eq({})
      end
    end

    context "when collection is not empty" do
      context "and some field restriction is applied" do
        let(:address_relationship) do
          instance_double(
            JsonApiObjectSerializer::Relationships::Base,
            serialize: { address: { data: { id: "address_id", type: "addresses" } } },
            serialized_name: :address
          )
        end

        let(:tasks_relationship) do
          instance_double(
            JsonApiObjectSerializer::Relationships::Base,
            serialized_name: :tasks
          )
        end

        before do
          relationship_collection.add(address_relationship)
          relationship_collection.add(tasks_relationship)
        end

        it "returns the serialized hash of only the permitted relationships" do
          resource = double(:resource)
          fieldset = instance_double(JsonApiObjectSerializer::Fieldset)

          allow(fieldset).to receive(:include?).with(:address).and_return(true)
          allow(fieldset).to receive(:include?).with(:tasks).and_return(false)

          expect(relationship_collection.serialize(resource, fieldset: fieldset)).to eq(
            relationships: {
              address: { data: { id: "address_id", type: "addresses" } }
            }
          )
        end
      end

      context "and field restriction is applied to all relatonships" do
        let(:address_relationship) do
          instance_double(
            JsonApiObjectSerializer::Relationships::Base,
            serialized_name: :address
          )
        end

        let(:tasks_relationship) do
          instance_double(
            JsonApiObjectSerializer::Relationships::Base,
            serialized_name: :tasks
          )
        end

        before do
          relationship_collection.add(address_relationship)
          relationship_collection.add(tasks_relationship)
        end

        it "returns an empty hash" do
          resource = double(:resource)
          fieldset = instance_double(JsonApiObjectSerializer::Fieldset, include?: false)

          expect(relationship_collection.serialize(resource, fieldset: fieldset)).to eq({})
        end
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
