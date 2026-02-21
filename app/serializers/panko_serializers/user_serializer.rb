module PankoSerializers
  class UserSerializer < Panko::Serializer
    attributes :id, :name, :email
  end
end
