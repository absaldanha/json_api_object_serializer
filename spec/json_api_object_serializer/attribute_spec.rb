# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Attribute do
  subject(:attribute) { JsonApiObjectSerializer::Attribute.new(name: :foo_bar) }

  it "sets attributes correctly" do
    expect(attribute).to have_attributes(name: :foo_bar, serialized_name: :"foo-bar")
  end
end
