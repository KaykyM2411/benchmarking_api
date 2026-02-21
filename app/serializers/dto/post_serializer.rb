module Dto
  class PostSerializer
    class << self
      def serialize(post)
        {
          id: post.id,
          title: post.title,
          body: post.body,
          user: Dto::UserSerializer.serialize(post.user),
          comments: post.comments.map { |comment| Dto::CommentSerializer.serialize(comment) }
        }
      end
    end
  end
end
