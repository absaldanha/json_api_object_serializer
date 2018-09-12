# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Relationships do
  describe ".build" do
    context "when to build a has_one relationship" do
      it "returns an instance of Relationships::HasOne" do
        expect(JsonApiObjectSerializer::Relationships.build(:has_one, name: :foo, type: "foos"))
          .to be_an_instance_of JsonApiObjectSerializer::Relationships::HasOne
      end
    end

    context "when to build an unknown relationship" do
      it "returns an instance of Relationships::Base" do
        expect(JsonApiObjectSerializer::Relationships.build(:unknown, name: :foo, type: "foos"))
          .to be_an_instance_of JsonApiObjectSerializer::Relationships::Base
      end
    end
  end
end
