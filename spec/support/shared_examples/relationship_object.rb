# frozen_string_literal: true

RSpec.shared_examples "a relationship object" do
  it_behaves_like "a class with serialized name", name: :foo_bar, type: "foos"

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
end
