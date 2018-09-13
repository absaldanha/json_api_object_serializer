# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include DummyObject
  include JsonApiMatchers

  describe "serializer relationships" do
    let(:serializer_class) do
      Class.new do
        include JsonApiObjectSerializer

        type "dummies"

        attributes :first_name, :last_name
      end
    end

    context "with a has one relationship" do
      context "without an alias" do
        it "serializes the object correctly with the has one relationship" do
          serializer_class.has_one :address, type: "addresses"

          attributes = { first_name: "Alexandre", last_name: "Saldanha" }

          dummy_address = dummy_object(id: 12)
          dummy_user = dummy_object(id: 123, attributes: attributes.merge(address: dummy_address))
          serializer = serializer_class.new

          expect(serializer.to_hash(dummy_user)).to eq(
            data: {
              id: "123",
              type: "dummies",
              attributes: { "first-name": "Alexandre", "last-name": "Saldanha" },
              relationships: {
                address: { data: { type: "addresses", id: "12" } }
              }
            }
          )
        end
      end

      context "with an alias" do
        it "serializes the object correctly with the has one relationship alias" do
          serializer_class.has_one :address, type: "addresses", as: :local

          attributes = { first_name: "Alexandre", last_name: "Saldanha" }

          dummy_address = dummy_object(id: 12)
          dummy_user = dummy_object(id: 123, attributes: attributes.merge(address: dummy_address))
          serializer = serializer_class.new

          expect(serializer.to_hash(dummy_user)).to eq(
            data: {
              id: "123",
              type: "dummies",
              attributes: { "first-name": "Alexandre", "last-name": "Saldanha" },
              relationships: {
                local: { data: { type: "addresses", id: "12" } }
              }
            }
          )
        end
      end
    end
  end
end
