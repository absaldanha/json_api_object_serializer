# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::NullLinkCollection do
  subject(:null_link_collection) { JsonApiObjectSerializer::NullLinkCollection.new }

  describe "#empty?" do
    it "always returns true" do
      expect(null_link_collection.empty?).to be true
    end
  end

  describe "#serialize" do
    it "always returns an empty hash" do
      resource = double(:resource)

      expect(null_link_collection.serialize(resource)).to eq({})
    end
  end
end
