# frozen_string_literal: true

RSpec.describe "Top level meta", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      meta copyright: "Foo Copyright", authors: ["Alexandre Saldanha", "Foo Author"],
           related_meta: { fuz: "Fuz", baz: "Baz" }

      type "foos"
      attribute :foo
    end
  end

  it "renders the correct resource hash with the specified meta object" do
    resource = double(:resource, id: 1, foo: "Foo")

    result = serializer.to_hash(resource)

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match(
        a_hash_including(
          meta: a_hash_including(
            copyright: "Foo Copyright", authors: ["Alexandre Saldanha", "Foo Author"],
            "related-meta": { fuz: "Fuz", baz: "Baz" }
          )
        )
      )
    end
  end
end
