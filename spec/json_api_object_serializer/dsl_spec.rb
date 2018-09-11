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
    end
  end

  describe "#type" do
    it "sets the resource type" do
      class_with_dsl.type "dummy type"
      expect(class_with_dsl._type).to eq "dummy type"
    end
  end

  describe "#attribute" do
    it "adds a new attribute to attribute collection" do
      expect do
        class_with_dsl.attribute :foo
      end.to change { class_with_dsl._attribute_collection_size }.from(0).to(1)
    end
  end
end
