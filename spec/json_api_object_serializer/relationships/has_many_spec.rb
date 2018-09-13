# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasMany do
  include DummyObject

  it_behaves_like "a relationship object"

  describe "#serialization_of" do
    subject(:relationship) do
      JsonApiObjectSerializer::Relationships::HasMany.new(name: :foo_bar, type: "foos")
    end

    it "returns the serialized hash of this relationship for the given resource object" do
      dummy_foo_bar = [dummy_object(id: 1), dummy_object(id: 2)]
      dummy_user = dummy_object(attributes: { foo_bar: dummy_foo_bar })

      expect(relationship.serialization_of(dummy_user)).to eq(
        "foo-bar": { data: [{ id: "1", type: "foos" }, { id: "2", type: "foos" }] }
      )
    end
  end
end
