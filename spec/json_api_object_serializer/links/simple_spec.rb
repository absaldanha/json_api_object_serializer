# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Links::Simple do
  describe "#serialize" do
    subject(:link) do
      JsonApiObjectSerializer::Links::Simple.new("foo-bar") do |resource|
        "foos/#{resource.id}"
      end
    end

    it "serializes the link correctly" do
      resource = double(:resource, id: "foo-id")

      expect(link.serialize(resource)).to eq("foo-bar": "foos/foo-id")
    end
  end
end
