# frozen_string_literal: true

RSpec.describe "Resource Links", type: :integration do
  context "with a simple link object" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        links do
          simple(:self) { |resource| "http://example.com/resources/foos/#{resource.id}" }
        end

        type "foos"
        attribute :foo
      end
    end

    it "serializes the resource with its links object" do
      resource = double(:resource, id: 1, foo: "Foo")

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          a_hash_including(
            links: {
              self: "http://example.com/resources/foos/1"
            }
          )
        )
      end
    end
  end

  context "with compound link" do
    subject(:serializer) do
      Class.new do
        include JsonApiObjectSerializer

        links do
          compound :related do
            href { |resource| "http://example.com/resources/foos/#{resource.id}" }
            meta { |_resource| { key1: "value1", key2: "value2" } }
          end
        end

        type "foos"
        attribute :foo
      end
    end

    it "serializes the resource with its links object" do
      resource = double(:resource, id: 1, foo: "Foo")

      result = serializer.to_hash(resource)

      aggregate_failures do
        expect(result).to match_jsonapi_schema
        expect(result).to match(
          a_hash_including(
            links: {
              related: {
                href: "http://example.com/resources/foos/1",
                meta: {
                  key1: "value1", key2: "value2"
                }
              }
            }
          )
        )
      end
    end
  end
end
