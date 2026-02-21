module Dto
  class CommentSerializer
    class << self
      def serialize(comment)
        {
          id: comment.id,
          body: comment.body,
          user: Dto::UserSerializer.serialize(comment.user)
        }
      end
    end
  end
end
