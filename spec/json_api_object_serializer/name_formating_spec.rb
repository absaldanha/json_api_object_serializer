# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::NameFormating do
  include DummyObject

  subject(:dummy) { dummy_object }

  before do
    dummy.extend(JsonApiObjectSerializer::NameFormating)
  end

  describe "#name_formating_of" do
    it "formats the given string correctly" do
      expect(dummy.name_formating_of(:foo_bar)).to eq "foo-bar"
    end
  end
end
