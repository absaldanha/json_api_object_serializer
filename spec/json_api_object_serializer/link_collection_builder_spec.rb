# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::LinkCollectionBuilder do
  describe ".build" do
    it "builds a new link collection and returns it" do
      result = JsonApiObjectSerializer::LinkCollectionBuilder.build do
        simple(:foo) { |_resource| "foo" }
        simple(:bar) { |_resource| "bar" }
      end

      aggregate_failures do
        expect(result).to be_an_instance_of JsonApiObjectSerializer::LinkCollection
        expect(result.size).to eq 2
      end
    end
  end

  describe "#build" do
    subject(:link_collection_builder) { JsonApiObjectSerializer::LinkCollectionBuilder.new }

    it "builds and returns the link collection" do
      result = link_collection_builder.build do
        simple(:foo) { |_resource| "foo" }
        simple(:bar) { |_resource| "bar" }
      end

      aggregate_failures do
        expect(result).to be_an_instance_of JsonApiObjectSerializer::LinkCollection
        expect(result.size).to eq 2
      end
    end
  end
end
