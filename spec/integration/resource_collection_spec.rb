# frozen_string_literal: true

RSpec.describe "Resource collection", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "foos"
      attributes :foo, :bar
    end
  end

  it "serializes the collection correctly" do
    resource1 = double(:resource1, id: 1, foo: "Foo", bar: "Bar")
    resource2 = double(:resource2, id: 2, foo: "Fus", bar: "RO-DAH")

    result = serializer.to_hash([resource1, resource2], collection: true)

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match(
        data: contain_exactly(
          { type: "foos", id: "1", attributes: { foo: "Foo", bar: "Bar" } },
          type: "foos", id: "2", attributes: { foo: "Fus", bar: "RO-DAH" }
        )
      )
    end
  end
end
