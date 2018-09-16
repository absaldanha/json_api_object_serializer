# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Identifier do
  subject(:identifier) { JsonApiObjectSerializer::Identifier.new }

  describe "#id=" do
    it "sets the new id as a proc" do
      identifier.id = :custom_id
      expect(identifier.id).to be_an_instance_of Proc
    end
  end

  describe "#type=" do
    it "sets the new type as a string" do
      identifier.type = :foos
      expect(identifier.type).to eq "foos"
    end
  end

  describe "#serialized_identifier_of" do
    it "returns the serialized identifier hash of the given resource object" do
      identifier.type = "foos"
      resource_object = double(:resource_object, id: 1)

      expect(identifier.serialized_identifier_of(resource_object))
        .to eq id: "1", type: "foos"
    end
  end
end
