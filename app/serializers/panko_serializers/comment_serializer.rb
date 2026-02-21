module PankoSerializers
  class CommentSerializer < Panko::Serializer
    attributes :id, :body

    has_one :user, serializer: PankoSerializers::UserSerializer
  end
end
