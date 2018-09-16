# frozen_string_literal: true

RSpec.describe JsonApiObjectSerializer do
  include JsonMatcher

  describe "serializer relationships" do
    let(:serializer_class) do
      Class.new do
        include JsonApiObjectSerializer

        type "dummies"

        attributes :first_name, :last_name
      end
    end

    context "with a has one relationship" do
      context "without an alias" do
        it "serializes the object correctly with the has one relationship" do
          serializer_class.has_one :address, type: "addresses"

          dummy_address = double(:address, id: 12)
          dummy = double(
            :dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha", address: dummy_address
          )
          serializer = serializer_class.new

          result = serializer.to_hash(dummy)

          aggregate_failures do
            expect(result).to match_jsonapi_schema
            expect(result).to match(
              a_hash_including(
                data: a_hash_including(
                  relationships: a_hash_including(
                    address: { data: { type: "addresses", id: "12" } }
                  )
                )
              )
            )
          end
        end
      end

      context "with an alias" do
        it "serializes the object correctly with the has one relationship alias" do
          serializer_class.has_one :address, type: "addresses", as: :local

          dummy_address = double(:dummy_address, id: 12)
          dummy = double(
            :dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha", address: dummy_address
          )
          serializer = serializer_class.new

          result = serializer.to_hash(dummy)

          aggregate_failures do
            expect(result).to match_jsonapi_schema
            expect(result).to match(
              a_hash_including(
                data: a_hash_including(
                  relationships: a_hash_including(
                    local: { data: { type: "addresses", id: "12" } }
                  )
                )
              )
            )
          end
        end
      end
    end

    context "with a has many relationship" do
      context "without an alias" do
        it "serializes correctly with the has many relationship" do
          serializer_class.has_many :tasks, type: "tasks"

          dummy_tasks = [double(:task1, id: 1), double(:task2, id: 2)]
          dummy = double(
            :dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha", tasks: dummy_tasks
          )
          serializer = serializer_class.new

          result = serializer.to_hash(dummy)

          aggregate_failures do
            expect(result).to match_jsonapi_schema
            expect(result).to match(
              a_hash_including(
                data: a_hash_including(
                  relationships: a_hash_including(
                    tasks: { data: [{ type: "tasks", id: "1" }, { type: "tasks", id: "2" }] }
                  )
                )
              )
            )
          end
        end
      end

      context "with an alias" do
        it "serializes correctly with the has many relationship alias" do
          serializer_class.has_many :tasks, type: "tasks", as: :todos

          dummy_tasks = [double(:task1, id: 1), double(:task2, id: 2)]
          dummy = double(
            :dummy, id: 123, first_name: "Alexandre", last_name: "Saldanha", tasks: dummy_tasks
          )
          serializer = serializer_class.new

          result = serializer.to_hash(dummy)

          aggregate_failures do
            expect(result).to match_jsonapi_schema
            expect(result).to match(
              data: a_hash_including(
                relationships: a_hash_including(
                  todos: { data: [{ type: "tasks", id: "1" }, { type: "tasks", id: "2" }] }
                )
              )
            )
          end
        end
      end
    end
  end
end
