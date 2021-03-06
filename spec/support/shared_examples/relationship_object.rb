# frozen_string_literal: true

RSpec.shared_examples "a relationship object" do
  it_behaves_like "a class with serialized name", name: :foo_bar, type: "foos"

  it "sets the correct relationship identifier" do
    relationship = described_class.new(name: :foo, type: "foos")

    aggregate_failures do
      expect(relationship.identifier).to be_an_instance_of JsonApiObjectSerializer::Identifier
      expect(relationship.identifier.type).to eq "foos"
    end
  end

  describe "#eql?" do
    subject(:relationship) { described_class.new(name: :foo_bar, type: "foos") }

    it "is based on name of the relationship" do
      other_equal_relationship = described_class.new(name: :foo_bar, as: :bar, type: "foos")
      other_different_relationship = described_class.new(name: :foo, type: "foos")

      expect(relationship.eql?(other_equal_relationship)).to be true
      expect(relationship.eql?(other_different_relationship)).to be false
    end
  end

  describe "#hash" do
    subject(:relationship) { described_class.new(name: :foo_bar, type: "foos") }

    it "is based on name of the relationship" do
      other_equal_relationship = described_class.new(name: :foo_bar, as: :bar, type: "foos")
      other_different_relationship = described_class.new(name: :foo, type: "foos")

      expect(relationship.hash).not_to eq other_different_relationship.hash
      expect(relationship.hash).to eq other_equal_relationship.hash
    end
  end

  describe "#fully_serialize" do
    let!(:relationship_serializer) { spy(:relationship_serializer) }

    subject(:relationship) do
      described_class.new(name: :foo, type: "foos", serializer: relationship_serializer)
    end

    it "uses the given serializer to fully serialize the relationship" do
      foo_relationship = double(:foo_relationship)
      resource = double(:resource, foo: foo_relationship)

      subject.fully_serialize(resource)
      expect(relationship_serializer).to have_received(:to_hash)
        .with(foo_relationship, a_hash_including(fields: {}))
    end
  end
end
