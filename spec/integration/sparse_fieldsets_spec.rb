# frozen_string_literal: true

RSpec.describe "Sparse fieldsets", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "foos"
      attributes :foo, :bar
      has_one :buz, type: "buzes"
    end
  end

  it "serializes the resource correctly with only the specified attributes" do
    buz_relationship = double(:buz_relationship, id: 1)
    resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", buz: buz_relationship)

    result = serializer.to_hash(resource, fields: { foos: [:foo] })

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match data: { id: "1", type: "foos", attributes: { foo: "Foo" } }
    end
  end
end
