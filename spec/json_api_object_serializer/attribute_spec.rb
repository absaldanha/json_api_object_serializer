# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Attribute do
  it_behaves_like "a class with serialized name", name: :foo_bar

  subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo) }

  describe "#serialize" do
    it "returns the serialized hash of this attribute of the given resource object" do
      resource = double(:resource, foo: "foo123")

      expect(attribute.serialize(resource)).to eq foo: "foo123"
    end
  end

  describe "#eql?" do
    it "is based on name of the attribute" do
      other_different_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo_bar)
      other_equal_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo, as: :baz)

      expect(attribute.eql?(other_equal_attribute)).to be true
      expect(attribute.eql?(other_different_attribute)).to be false
    end
  end

  describe "#hash" do
    it "is based on name of the attribute" do
      other_different_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo_bar)
      other_equal_attribute = JsonApiObjectSerializer::Attribute.new(name: :foo, as: :baz)

      expect(attribute.eql?(other_equal_attribute)).to be true
      expect(attribute.eql?(other_different_attribute)).to be false
    end
  end
end
