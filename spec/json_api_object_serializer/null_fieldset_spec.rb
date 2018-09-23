# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::NullFieldset do
  subject(:null_fieldset) { JsonApiObjectSerializer::NullFieldset.new }

  describe "#include?" do
    it "always return true" do
      expect(null_fieldset.include?(:bar)).to be true
      expect(null_fieldset.include?(:foo)).to be true
    end
  end

  describe "#all_fields" do
    it "always return an empty hash" do
      expect(null_fieldset.all_fields).to eq({})
    end
  end
end
