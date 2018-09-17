# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include JsonMatcher

  describe "custom ID" do
    context "with a symbol" do
      let(:serializer_class) do
        Class.new do
          include JsonApiObjectSerializer

          id :custom_id
          type "dummies"
          attribute :foo
        end
      end

      it "serializes the object correctly with the declared custom ID" do
        dummy = double(:dummy, foo: "Foo", custom_id: "custom-id-1")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                type: "dummies", id: "custom-id-1"
              )
            )
          )
        end
      end
    end

    # context "with a proc" do
    # end
  end
end
