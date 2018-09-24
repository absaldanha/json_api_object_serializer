# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Fieldset do
  describe ".build" do
    context "when the given type has no specified fields" do
      it "returns a NullFieldset" do
        expect(JsonApiObjectSerializer::Fieldset.build("foo", bar: %i[fuz buz])).to(
          be_an_instance_of(JsonApiObjectSerializer::NullFieldset)
        )
      end
    end

    context "when the given type has specified fields" do
      it "returns a Fieldset" do
        expect(JsonApiObjectSerializer::Fieldset.build("foo", foo: %i[bar baz])).to(
          be_an_instance_of(JsonApiObjectSerializer::Fieldset)
        )
      end
    end
  end
end
