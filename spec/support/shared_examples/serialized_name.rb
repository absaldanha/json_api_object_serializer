# frozen_string_literal: true

RSpec.shared_examples "a class with serialized name" do |**instantiation_attributes|
  context "with an alias option" do
    subject { described_class.new(instantiation_attributes.merge(as: :baz_foo)) }

    it "sets the correct serialized name" do
      expect(subject.serialized_name).to eq :"baz-foo"
    end
  end

  context "without an alias option" do
    subject { described_class.new(instantiation_attributes) }

    it "sets the correct serialized name" do
      computed_serialized_name = instantiation_attributes[:name].to_s.tr("_", "-").to_sym
      expect(subject.serialized_name).to eq computed_serialized_name
    end
  end
end
