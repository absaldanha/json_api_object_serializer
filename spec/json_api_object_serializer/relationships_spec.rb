# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships do
  describe ".has_one" do
    it "returns a new HasOne object" do
      expect(JsonApiObjectSerializer::Relationships.has_one(name: :foo, type: "foos"))
        .to be_an_instance_of(JsonApiObjectSerializer::Relationships::HasOne)
    end
  end

  describe ".has_many" do
    it "returns a new HasMany object" do
      expect(JsonApiObjectSerializer::Relationships.has_many(name: :foo, type: "foos"))
        .to be_an_instance_of(JsonApiObjectSerializer::Relationships::HasMany)
    end
  end
end
