# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::NullLinkCollection do
  describe "#empty?" do
    subject(:null_link_collection) { JsonApiObjectSerializer::NullLinkCollection.new }

    it "always returns true" do
      expect(null_link_collection.empty?).to be true
    end
  end
end
