# frozen_string_literal: true

RSpec.describe "Relationship Links", type: :integration do
  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "foos"
      attribute :foo

      has_many :bars, type: "bars" do
        links do
          simple(:self) { |_resource| "/foos/1/relationships/bars" }
          simple(:related) { |_resource| "/foos/1/bars" }
        end
      end

      has_one :buz, type: "buzes" do
        links do
          compound :related do
            href { |resource| "/foos/1/relationships/buz/#{resource.id}" }
            meta { |_resource| { useful: false } }
          end
        end
      end
    end
  end

  it "serializes the relationship with their links" do
    bars_relationships = [double(:bar1, id: 1), double(:bar2, id: 2)]
    buz_relationship = double(:buz, id: 1)
    resource = double(:resource, id: 1, foo: "Foo", bars: bars_relationships, buz: buz_relationship)

    result = serializer.to_hash(resource)

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match(
        data: a_hash_including(
          relationships: a_hash_including(
            bars: a_hash_including(
              links: {
                self: "/foos/1/relationships/bars",
                related: "/foos/1/bars"
              }
            ),
            buz: a_hash_including(
              links: {
                related: {
                  href: "/foos/1/relationships/buz/1",
                  meta: { useful: false }
                }
              }
            )
          )
        )
      )
    end
  end
end
