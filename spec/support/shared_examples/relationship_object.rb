# frozen_string_literal: true

RSpec.shared_examples "a relationship object" do
  it_behaves_like "a class with serialized name", name: :foo_bar, type: "foos"

  describe "#initialize" do
    it "sets the correct relationship identifier" do
      relationship = described_class.new(name: :foo, type: "foos")

      aggregate_failures do
        expect(relationship.identifier).to be_an_instance_of JsonApiObjectSerializer::Identifier
        expect(relationship.identifier.type).to eq "foos"
      end
    end

    context "with block given" do
      subject(:relationship) do
        described_class.new(name: :foo, type: "foos") do
          links do
            simple(:self) { |_resource| "simple_link" }
            compound(:related) do
              href { |_resource| "href_link" }
              meta { |_resource| { meta: "hash" } }
            end
          end
        end
      end

      it "sets builds the link collection correctly" do
        aggregate_failures do
          expect(relationship.link_collection)
            .to be_an_instance_of JsonApiObjectSerializer::LinkCollection
          expect(relationship.link_collection.size).to eq 2
        end
      end
    end
  end

  describe "#eql?" do
    subject(:relationship) { described_class.new(name: :foo_bar, type: "foos") }

    it "is based on name of the relationship" do
      other_equal_relationship = described_class.new(name: :foo_bar, as: :bar, type: "foos")
      other_different_relationship = described_class.new(name: :foo, type: "foos")

      expect(relationship.eql?(other_equal_relationship)).to be true
      expect(relationship.eql?(other_different_relationship)).to be false
    end
  end

  describe "#hash" do
    subject(:relationship) { described_class.new(name: :foo_bar, type: "foos") }

    it "is based on name of the relationship" do
      other_equal_relationship = described_class.new(name: :foo_bar, as: :bar, type: "foos")
      other_different_relationship = described_class.new(name: :foo, type: "foos")

      expect(relationship.hash).not_to eq other_different_relationship.hash
      expect(relationship.hash).to eq other_equal_relationship.hash
    end
  end

  describe "#serialize" do
    context "with links" do
      subject(:relationship) do
        described_class.new(name: :foo, type: "foos") do
          links do
            simple(:self) { |_resource| "simple_link" }
            compound(:related) do
              href { |_resource| "href_link" }
              meta { |_resource| { meta: "hash" } }
            end
          end
        end
      end

      it "serializes the relationship data with its links" do
        resource = double(:resource).as_null_object

        expect(relationship.serialize(resource)).to match(
          foo: a_hash_including(
            links: {
              self: "simple_link",
              related: {
                href: "href_link",
                meta: { meta: "hash" }
              }
            }
          )
        )
      end
    end

    context "without links" do
      subject(:relationship) { described_class.new(name: :foo_bar, type: "foos") }

      it "serializes only the relationship data" do
        resource = double(:resource).as_null_object

        result = relationship.serialize(resource)

        expect(result[:"foo-bar"]).not_to include(:links)
      end
    end
  end

  describe "#fully_serialize" do
    let!(:relationship_serializer) { spy(:relationship_serializer) }

    subject(:relationship) do
      described_class.new(name: :foo, type: "foos", serializer: relationship_serializer)
    end

    it "uses the given serializer to fully serialize the relationship" do
      foo_relationship = double(:foo_relationship)
      resource = double(:resource, foo: foo_relationship)

      subject.fully_serialize(resource)
      expect(relationship_serializer).to have_received(:to_hash)
        .with(foo_relationship, a_hash_including(fields: {}, include: []))
    end
  end
end
