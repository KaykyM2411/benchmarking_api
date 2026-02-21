module Dto
  class UserSerializer
    class << self
      def serialize(user)
        {
          id: user.id,
          name: user.name,
          email: user.email
        }
      end
    end
  end
end
