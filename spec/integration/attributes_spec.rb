# frozen_string_literal: true

RSpec.describe "Attributes", type: :integration do
  context "with singular form" do
    context "with an alias" do
      subject(:serializer) do
        Class.new do
          include JsonApiObjectSerializer

          type "foos"
          attribute :foo, as: :fus
        end
      end

      it "serializes the resource correctly with the attribute alias name" do
        resource = double(:resource, id: 1, foo: "Foo")

        result = serializer.to_hash(resource)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            data: a_hash_including(
              attributes: { fus: "Foo" }
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
          attribute :foo
        end
      end

      it "serializes the resource correctly with the attribute name" do
        resource = double(:resource, id: 1, foo: "Foo")

        result = serializer.to_hash(resource)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            data: a_hash_including(
              attributes: { foo: "Foo" }
            )
          )
        end
      end
    end
  end

  context "with plural form" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        type "foos"
        attributes :foo, :bar
      end
    end

    it "serializes the resource correctly with the attributes names" do
      resource = double(:resource, id: 1, foo: "Foo", bar: "Bar")

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          data: a_hash_including(
            attributes: { foo: "Foo", bar: "Bar" }
          )
        )
      end
    end
  end
end
