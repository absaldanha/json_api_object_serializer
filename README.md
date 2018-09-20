# JsonApiObjectSerializer

[![CircleCI](https://circleci.com/gh/absaldanha/json_api_object_serializer/tree/master.svg?style=svg)](https://circleci.com/gh/absaldanha/json_api_object_serializer/tree/master)

JsonApiObjectSerializer is yet another gem to help you to serialize your objecet into the [JSON:API format](http://jsonapi.org/format/).

It was designed to have a very explicit DSL, with no guessings about your object or project structure.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "json_api_object_serializer"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_api_object_serializer

## Usage
### Serializer definition

Any class can be a serializer including the `JsonApiObjectSerializer` mixin:

```ruby
class ArticleSerializer
  include JsonApiObjectSerializer

  type "articles"

  attributes :title, :body
  has_one :author, type: "authors"
  has_many :comments, type: "comments"
end
```

The module will add a simple interface for declaring a resource attributes, links, metadata and relationships.

It **does not** infer the resource type based on your class name or relationships names, so the declaration of `type` both in the resource and relationships are needed.

After the serializer definition, you can serialize an object calling `to_hash` or `to_json` methods:
```ruby
ArticleSerializer.to_hash(article)
```
Output:
```ruby
{
  data: {
    type: "articles",
    id: "1",
    attributes: {
      title: "Title",
      body: "Body"
    },
    relationships: {
      authors: {
        data: { type: "authors", id: "1" }
      },
      comments: {
        data: [
          { type: "comments", id: "1" }, { type: "comments", id: "2" }
        ]
      }
    }
  }
}
```
### Type

Because the resource type **will not** be infered from your class name or object, you **must** declare the resource type that will be serialized using the `type` method:
```ruby
type "articles"
```

### ID

It is expected that your object responds to the `id` method. If you want to use another value for ID, you can specify it using the `id` method:
```ruby
id :uuid
```

The method also can be used passing a proc, or any object that responds to `call` with one argument (the object being serialized):
```ruby
id ->(resource) { "my-unique-resource-id-#{resource.unique_method}" }
```

### Attributes

Attributes can be declared with `attribute` or `attributes` method:

```ruby
attribute :foo
attributes :bar, :baz
```
It is expected that your object responds to the declared attributes. For example, using the declaration above, it is expected that your object will respond to `foo`, `bar` and `baz`

If you want to expose the attribute with a different name, you can use the `as` option:
```ruby
attribute :foo, as: :moo
```
Which will then serialize your object with the `moo` key using the value of the `foo` method.

### Relationships

Relationships can be declared using the `has_one` method for to-one relationship or `has_many` method for to-many relationships:

```ruby
has_one :foo, type: "foos"
has_many :bars, type: "bars"
```
Again, the resource type **will not** be infered from the relationship name, so you must declare the type with `type`.

It is expected that your object will respond to the declared relationships. In case your document doesn't match your object structure, you can use the `as` option, just like in attribute declaration:
```ruby
has_one :user, as: :owner
has_many :tasks, as: :todos
```
For to-many relationships, besides expecting the object to respond to the named relationship, it is also expected to be a collection (it must respond to each), and that each member responds to `id`.

## Developing

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rspec` to run the tests and `bundle exec rubocop` to run the code linter.

## Contributing

1. Fork it (https://github.com/absaldanha/json_api_object_serializer)
2. Create your new feature or bug fix branch (`git checkout -b my-branch`)
3. Commit your changes (`git commit -A`) with a nice and explanatory text about your changes
4. Push your branch (`git push origin my-branch`)
5. Create new pull request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
