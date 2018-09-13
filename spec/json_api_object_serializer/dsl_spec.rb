# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::DSL do
  subject(:class_with_dsl) do
    Class.new do
      extend JsonApiObjectSerializer::DSL

      def self._type
        @type
      end

      def self._attribute_collection_size
        @attribute_collection.size
      end

      def self._relationship_collection_size
        @relationship_collection.size
      end
    end
  end

  describe "#type" do
    it "sets the resource type" do
      class_with_dsl.type "dummy type"
      expect(class_with_dsl._type).to eq "dummy type"
    end
  end

  describe "#attribute" do
    let!(:attribute_class) do
      class_spy("JsonApiObjectSerializer::Attribute").as_stubbed_const
    end

    it "adds a new attribute to attribute collection" do
      expect do
        class_with_dsl.attribute :foo
      end.to change { class_with_dsl._attribute_collection_size }.from(0).to(1)

      expect(attribute_class).to have_received(:new).with(name: :foo)
    end
  end

  describe "#attributes" do
    let(:attribute_foo) { double(:attribute_foo) }
    let(:attribute_bar) { double(:attribute_bar) }
    let!(:attribute_class) do
      class_spy("JsonApiObjectSerializer::Attribute").as_stubbed_const
    end

    before do
      allow(attribute_class).to receive(:new).and_return(attribute_foo, attribute_bar)
    end

    it "adds the new attributes to attribute collection" do
      expect do
        class_with_dsl.attributes :foo, :bar
      end.to change { class_with_dsl._attribute_collection_size }.from(0).to(2)

      expect(attribute_class).to have_received(:new).with(name: :foo)
      expect(attribute_class).to have_received(:new).with(name: :bar)
    end
  end

  describe "#has_one" do
    let!(:relationships_module) do
      class_spy("JsonApiObjectSerializer::Relationships").as_stubbed_const
    end

    it "adds new has_one relationship to relationship collection" do
      expect do
        class_with_dsl.has_one :foo, type: "foos"
      end.to change { class_with_dsl._relationship_collection_size }.from(0).to(1)

      expect(relationships_module).to have_received(:has_one).with(name: :foo, type: "foos")
    end
  end
end
