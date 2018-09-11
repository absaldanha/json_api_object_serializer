# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships::HasOne do
  include DummyObject

  subject(:relationship) do
    JsonApiObjectSerializer::Relationships::HasOne.new(name: :foo_bar, type: "foos")
  end

  it "sets attributes correctly" do
    expect(relationship).to have_attributes(
      name: :foo_bar, serialized_name: :"foo-bar", type: "foos"
    )
  end

  describe "#serialization_of" do
    it "returns the serialized hash of this relationship of the given resource object" do
      dummy_foo_bar = dummy_object(id: 1)
      dummy_user = dummy_object(attributes: { foo_bar: dummy_foo_bar })

      expect(relationship.serialization_of(dummy_user)).to eq(
        "foo-bar": { data: { id: "1", type: "foos" } }
      )
    end
  end
end