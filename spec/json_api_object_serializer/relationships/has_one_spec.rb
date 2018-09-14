# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasOne do
  it_behaves_like "a relationship object"

  describe "#serialization_of" do
    subject(:relationship) do
      JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo_bar, type: "foos")
    end

    it "returns the serialized hash of this relationship of the given resource object" do
      dummy_foo_bar = double(:dummy_foo_bar, id: 1)
      dummy = double(:dummy, foo_bar: dummy_foo_bar)

      expect(relationship.serialization_of(dummy)).to eq(
        "foo-bar": { data: { id: "1", type: "foos" } }
      )
    end
  end
end
