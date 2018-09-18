# frozen_string_literal: true

RSpec.describe "Custom ID", type: :integration do
  context "with a symbol" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        id :custom_id
        type "foos"
        attribute :foo
      end
    end

    it "serializes the resource correctly using the custom ID method" do
      resource = double(:resource, custom_id: "custom-id-1", foo: "Foo")

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(data: a_hash_including(id: "custom-id-1"))
      end
    end
  end

  context "with a proc" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        id ->(resource) { "my-resource-id-#{resource.id}" }
        type "foos"
        attribute :foo
      end
    end

    it "serializes the resource correctly using the custom ID proc" do
      resource = double(:resource, id: 1, foo: "Foo")

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(data: a_hash_including(id: "my-resource-id-1"))
      end
    end
  end
end
