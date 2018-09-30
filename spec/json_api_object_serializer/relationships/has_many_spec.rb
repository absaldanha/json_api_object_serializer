# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasMany do
  it_behaves_like "a relationship object"

  subject(:relationship) do
    JsonApiObjectSerializer::Relationships::HasMany.new(name: :foo_bar, type: "foos")
  end

  describe "#serialize_data" do
    it "returns the serialized data hash of this relationship for the given resource object" do
      foo_bar_relationship = [double(:foo_bar1, id: 1), double(:foo_bar2, id: 2)]
      resource = double(:resource, foo_bar: foo_bar_relationship)

      expect(relationship.serialize_data(resource)).to eq(
        data: [{ id: "1", type: "foos" }, { id: "2", type: "foos" }]
      )
    end
  end

  describe "#fully_serialize_options" do
    it "returns the correct options" do
      expect(relationship.fully_serialize_options).to eq(collection: true)
    end
  end
end
