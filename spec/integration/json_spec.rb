# frozen_string_literal: true

RSpec.describe "Serialize to JSON", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "foos"
      attributes :foo, :bar
    end
  end

  it "generates the serialized JSON correctly" do
    resource = double(:resource, id: 1, foo: "Foo", bar: "Bar")

    result = serializer.to_json(resource)

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match(
        <<~JSON.gsub(/^[\s\t]*|[\s\t]*\n/, "")
          {
            "data":{
              "id":"1",
              "type":"foos",
              "attributes":{
                "foo":"Foo",
                "bar":"Bar"
              }
            }
          }
        JSON
      )
    end
  end
end
