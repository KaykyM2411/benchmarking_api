module PankoSerializers
  class PostSerializer < Panko::Serializer
    attributes :id, :title, :body

    has_one :user, serializer: PankoSerializers::UserSerializer
    has_many :comments, serializer: PankoSerializers::CommentSerializer
  end
end
