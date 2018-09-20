# frozen_string_literal: true

RSpec.describe "Has one relationship", type: :integration do
  context "with an alias" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        type "foos"
        attributes :foo, :bar
        has_one :baz, type: "bazes", as: :buz
      end
    end

    it "serializes the resource correctly with the relationship alias name" do
      baz_relationship = double(:baz_relationship, id: 1)
      resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          data: a_hash_including(
            relationships: a_hash_including(
              buz: { data: { type: "bazes", id: "1" } }
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
        has_one :baz, type: "bazes"
      end
    end

    it "serializes the resource correctly with the relationship name" do
      baz_relationship = double(:baz_relationship, id: 1)
      resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          a_hash_including(
            data: a_hash_including(
              relationships: a_hash_including(
                baz: { data: { type: "bazes", id: "1" } }
              )
            )
          )
        )
      end
    end
  end

  context "with custom id" do
    context "with method name" do
      subject(:serializer) do
        Class.new do
          include JsonApiObjectSerializer

          type "foos"
          attributes :foo, :bar
          has_one :baz, type: "bazes", id: :uuid
        end
      end

      it "serializes the resource correctly with the custom relationship id method" do
        baz_relationship = double(:baz, uuid: "uuid-1")
        resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

        result = serializer.to_hash(resource)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            data: a_hash_including(
              relationships: a_hash_including(
                baz: { data: { type: "bazes", id: "uuid-1" } }
              )
            )
          )
        end
      end
    end

    context "with proc" do
      subject(:serializer) do
        Class.new do
          include JsonApiObjectSerializer

          type "foos"
          attributes :foo, :bar
          has_one :baz, type: "bazes", id: ->(resource) { "unique-id-#{resource.id}" }
        end
      end

      it "serializes the resource correctly with the custom relationship id method" do
        baz_relationship = double(:baz, id: 1)
        resource = double(:resource, id: 1, foo: "Foo", bar: "Bar", baz: baz_relationship)

        result = serializer.to_hash(resource)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            data: a_hash_including(
              relationships: a_hash_including(
                baz: { data: { type: "bazes", id: "unique-id-1" } }
              )
            )
          )
        end
      end
    end
  end
end
