# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include DummyObject
  include JsonApiMatchers

  subject(:serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "dummies"
      attribute :first_name
      attribute :last_name
    end.new
  end

  it "serializes the object with their attributes correctly" do
    attributes = { first_name: "Alexandre", last_name: "Saldanha" }
    dummy = dummy_object(id: 123, attributes: attributes)

    expect(serializer.to_hash(dummy))
      .to match_json_api_data(attributes: attributes, id: 123, type: "dummies")
  end
end
