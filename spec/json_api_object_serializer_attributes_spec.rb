# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include JsonMatcher

  describe "serializer attributes" do
    let(:serializer_class) do
      Class.new do
        include JsonApiObjectSerializer
        type "dummies"
      end
    end

    context "with singular form" do
      it "serializes the object correctly with the declared attributes" do
        serializer_class.attribute :first_name
        serializer_class.attribute :last_name

        dummy = double(:dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                attributes: { "first-name": "Alexandre", "last-name": "Saldanha" }
              )
            )
          )
        end
      end

      it "doesn't repeat an attribute" do
        serializer_class.attribute :first_name
        serializer_class.attribute :first_name

        dummy = double(:dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                attributes: { "first-name": "Alexandre" }
              )
            )
          )
        end
      end
    end

    context "with plural form" do
      it "serializes the object correctly with the declared attributes" do
        serializer_class.attributes :first_name, :last_name

        dummy = double(:dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                attributes: { "first-name": "Alexandre", "last-name": "Saldanha" }
              )
            )
          )
        end
      end

      it "doesn't repeat an attribute" do
        serializer_class.attributes :first_name, :first_name

        dummy = double(:dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                attributes: { "first-name": "Alexandre" }
              )
            )
          )
        end
      end
    end

    context "with alias" do
      it "serializes the object correctly with the declared attributes and aliases" do
        serializer_class.attribute :first_name, as: :my_first_name
        serializer_class.attribute :last_name, as: :my_last_name

        dummy = double(:dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha")
        serializer = serializer_class.new

        result = serializer.to_hash(dummy)

        aggregate_failures do
          expect(result).to match_jsonapi_schema
          expect(result).to match(
            a_hash_including(
              data: a_hash_including(
                attributes: { "my-first-name": "Alexandre", "my-last-name": "Saldanha" }
              )
            )
          )
        end
      end
    end
  end
end
