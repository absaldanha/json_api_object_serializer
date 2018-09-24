# frozen_string_literal: true

RSpec.describe "Has many relationship", type: :integration do
  context "with an alias" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        type "foos"
        attributes :foo, :bar
        has_many :baz, as: :buz, type: "bazes"
      end
    end

    it "serializes the resource correctly with the relationship alias name" do
      baz_relationship = [double(:baz1, id: 1), double(:baz2, id: 2)]
      resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          data: a_hash_including(
            relationships: a_hash_including(
              buz: { data: [{ type: "bazes", id: "1" }, { type: "bazes", id: "2" }] }
            )
          )
        )
      end
    end
  end

  context "without an alias" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        type "foos"
        attributes :foo, :bar
        has_many :baz, type: "bazes"
      end
    end

    it "serializes the resource correctly with the relationship name" do
      baz_relationship = [double(:baz1, id: 1), double(:baz2, id: 2)]
      resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          data: a_hash_including(
            relationships: a_hash_including(
              baz: { data: [{ type: "bazes", id: "1" }, { type: "bazes", id: "2" }] }
            )
          )
        )
      end
    end
  end
end
