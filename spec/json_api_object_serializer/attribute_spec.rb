# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Attribute do
  include DummyObject

  it_behaves_like "a class with serialized name", name: :foo_bar

  describe "#serialization_of" do
    subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo) }

    it "returns the serialized hash of this attribute of the given resource object" do
      dummy = dummy_object(attributes: { foo: "foo123" })

      expect(attribute.serialization_of(dummy)).to eq foo: "foo123"
    end
  end

  describe "#eql?" do
    subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo) }

    it "is based on name of the attribute" do
      other_different_attribute = described_class.new(name: :foo_bar)
      other_equal_attribute = described_class.new(name: :foo, as: :baz)

      expect(attribute.eql?(other_equal_attribute)).to be true
      expect(attribute.eql?(other_different_attribute)).to be false
    end
  end

  describe "#hash" do
    subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo) }

    it "is based on name of the attribute" do
      other_different_attribute = described_class.new(name: :foo_bar)
      other_equal_attribute = described_class.new(name: :foo, as: :baz)

      expect(attribute.eql?(other_equal_attribute)).to be true
      expect(attribute.eql?(other_different_attribute)).to be false
    end
  end
end
