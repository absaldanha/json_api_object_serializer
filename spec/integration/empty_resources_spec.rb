# frozen_string_literal: true

RSpec.describe "Empty resources", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "foos"
      attributes :foo, :bar
    end
  end

  context "without the collection option" do
    context "when the resource is nil" do
      it "returns the correct empty serialized hash for single resource" do
        result = serializer.to_hash(nil)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to eq data: nil
        end
      end
    end
  end

  context "with the collection option" do
    context "with empty collection" do
      it "returns the correct empty serialized hash for resource collection" do
        result = serializer.to_hash([], collection: true)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to eq data: []
        end
      end
    end

    context "with collection with only nil" do
      it "returns the correct empty serialized hash for resource collection" do
        result = serializer.to_hash([nil, nil, nil], collection: true)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to eq data: []
        end
      end
    end

    context "with nil collection" do
      it "returns the correct empty serialized hash for resource collection" do
        result = serializer.to_hash(nil, collection: true)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to eq data: []
        end
      end
    end
  end
end
