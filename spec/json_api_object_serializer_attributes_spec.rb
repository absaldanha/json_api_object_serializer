# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include DummyObject
  include JsonApiMatchers

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

        attributes = { first_name: "Alexandre", last_name: "Saldanha" }

        dummy = dummy_object(id: 123, attributes: attributes)
        serializer = serializer_class.new

        expect(serializer.to_hash(dummy))
          .to match_json_api_data(attributes: attributes, id: 123, type: "dummies")
      end

      it "doesn't repeat an attribute" do
        serializer_class.attribute :first_name
        serializer_class.attribute :first_name

        attributes = { first_name: "Alexandre", last_name: "Saldanha" }

        dummy = dummy_object(id: 123, attributes: attributes)
        serializer = serializer_class.new

        expect(serializer.to_hash(dummy)).to match_json_api_data(
          attributes: attributes.slice(:first_name), id: 123, type: "dummies"
        )
      end
    end

    context "with plural form" do
      it "serializes the object correctly with the declared attributes" do
        serializer_class.attributes :first_name, :last_name

        attributes = { first_name: "Alexandre", last_name: "Saldanha" }

        dummy = dummy_object(id: 123, attributes: attributes)
        serializer = serializer_class.new

        expect(serializer.to_hash(dummy))
          .to match_json_api_data(attributes: attributes, id: 123, type: "dummies")
      end

      it "doesn't repeat an attribute" do
        serializer_class.attributes :first_name, :first_name

        attributes = { first_name: "Alexandre", last_name: "Saldanha" }

        dummy = dummy_object(id: 123, attributes: attributes)
        serializer = serializer_class.new

        expect(serializer.to_hash(dummy)).to match_json_api_data(
          attributes: attributes.slice(:first_name), id: 123, type: "dummies"
        )
      end
    end

    context "with alias" do
      it "serializes the object correctly with the declared attributes and aliases" do
        serializer_class.attribute :first_name, as: :my_first_name
        serializer_class.attribute :last_name, as: :my_last_name

        dummy = dummy_object(
          id: 123, attributes: { first_name: "Alexandre", last_name: "Saldanha" }
        )
        serializer = serializer_class.new

        expect(serializer.to_hash(dummy)).to eq(
          data: {
            id: "123",
            type: "dummies",
            attributes: {
              "my-first-name": "Alexandre", "my-last-name": "Saldanha"
            }
          }
        )
      end
    end
  end
end
