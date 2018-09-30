# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasOne do
  it_behaves_like "a relationship object"

  subject(:relationship) do
    JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo_bar, type: "foos")
  end

  describe "#serialize_data" do
    it "returns the serialized data hash of this relationship of the given resource object" do
      foo_bar_relationship = double(:foo_bar, id: 1)
      resource = double(:resource, foo_bar: foo_bar_relationship)

      expect(relationship.serialize_data(resource)).to eq(
        data: { id: "1", type: "foos" }
      )
    end
  end
end
