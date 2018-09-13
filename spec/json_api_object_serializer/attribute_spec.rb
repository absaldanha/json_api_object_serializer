# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Attribute do
  context "with an alias option" do
    subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo_bar, as: :baz_foo) }

    it "sets attributes correctly" do
      expect(attribute).to have_attributes(name: :foo_bar, serialized_name: :"baz-foo")
    end
  end

  context "without an alias option" do
    subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo_bar) }

    it "sets attributes correctly" do
      expect(attribute).to have_attributes(name: :foo_bar, serialized_name: :"foo-bar")
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
