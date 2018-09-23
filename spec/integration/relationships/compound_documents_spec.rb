# frozen_string_literal: true

RSpec.describe "Compound documents", type: :integration do
  class UserSerializer
    include JsonApiObjectSerializer

    type "people"
    attributes :first_name, :last_name
    has_many :articles, type: "articles"
    has_many :comments, type: "comments"
  end

  class CommentSerializer
    include JsonApiObjectSerializer

    type "comments"
    attribute :body
    has_one :user, as: :author, type: "people"
    has_one :article, type: "articles"
  end

  subject(:article_serializer) do
    Class.new do
      include JsonApiObjectSerializer

      type "articles"
      attributes :title, :body
      has_one :user, as: :author, type: "people", serializer: UserSerializer
      has_many :comments, type: "comments", serializer: CommentSerializer
    end
  end

  it "serializes the object correctly, including the addtional compound documents" do
    article_author = double(:article_author, id: 1, first_name: "Alexandre", last_name: "Saldanha")
    first_comment_author =
      double(:first_comment_author, id: 2, first_name: "Nathália", last_name: "Oliveira")
    first_comment =
      double(:first_comment, id: 1, body: "Comment 1 Body", user: first_comment_author)
    second_comment = double(:second_comment, id: 2, body: "Comment 2 Body", user: article_author)
    article = double(
      :article, id: 1, user: article_author, title: "Title",
                body: "Article body", comments: [first_comment, second_comment]
    )

    # circular dependency
    allow(article_author).to receive(:articles).and_return([article])
    allow(article_author).to receive(:comments).and_return([second_comment])
    allow(first_comment_author).to receive(:comments).and_return([first_comment])
    allow(first_comment).to receive(:article).and_return(article)
    allow(second_comment).to receive(:article).and_return(article)

    result = article_serializer.to_hash(article, include: %i[author comments])

    aggregate_failures do
      expect(result).to match_jsonapi_schema
      expect(result).to match(
        a_hash_including(
          included: contain_exactly(
            {
              id: "1", type: "people",
              attributes: { "first-name": "Alexandre", "last-name": "Saldanha" },
              relationships: {
                articles: { data: [{ id: "1", type: "articles" }] },
                comments: { data: [{ id: "2", type: "comments" }] }
              }
            },
            {
              id: "1", type: "comments",
              attributes: { body: "Comment 1 Body" },
              relationships: {
                author: { data: { id: "2", type: "people" } },
                article: { data: { id: "1", type: "articles" } }
              }
            },
            id: "2", type: "comments",
            attributes: { body: "Comment 2 Body" },
            relationships: {
              author: { data: { id: "1", type: "people" } },
              article: { data: { id: "1", type: "articles" } }
            }
          )
        )
      )
    end
  end
end
