# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer::Links do
  describe ".simple" do
    it "creates a new SimpleLink with the given block" do
      result = JsonApiObjectSerializer::Links.simple(:self) { |resource| "foos/#{resource.id}" }
      expect(result).to be_an_instance_of JsonApiObjectSerializer::Links::Simple
    end
  end

  describe ".compound" do
    it "creates a new Compound with the given block" do
      result = JsonApiObjectSerializer::Links.compound :foo do
        href { |resource| "foos/#{resource.id}" }
        meta { |_resource| { meta_key1: "value1", meta_key2: "value2" } }
      end

      expect(result).to be_an_instance_of JsonApiObjectSerializer::Links::Compound
    end
  end
end
