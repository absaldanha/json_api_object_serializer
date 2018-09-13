# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasOne do
  include DummyObject

  it_behaves_like "a relationship object"

  describe "#serialization_of" do
    subject(:relationship) do
      JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo_bar, type: "foos")
    end

    it "returns the serialized hash of this relationship of the given resource object" do
      dummy_foo_bar = dummy_object(id: 1)
      dummy_user = dummy_object(attributes: { foo_bar: dummy_foo_bar })

      expect(relationship.serialization_of(dummy_user)).to eq(
        "foo-bar": { data: { id: "1", type: "foos" } }
      )
    end
  end
end
