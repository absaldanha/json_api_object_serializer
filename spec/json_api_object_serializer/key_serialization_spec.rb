# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::KeySerialization do
  describe "#serialized_key" do
    subject do
      Class.new do
        include JsonApiObjectSerializer::KeySerialization
      end.new
    end

    it "transforms the key correctly" do
      expect(subject.serialized_key(:foo_bar)).to eq :"foo-bar"
    end
  end
end
