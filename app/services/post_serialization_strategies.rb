class PostSerializationStrategies
  AS_JSON_INCLUDE = [:user, { comments: { include: :user } }].freeze

  class << self
    def as_json(posts)
      posts.as_json(include: AS_JSON_INCLUDE)
    end

    def dto(posts)
      {
        posts: posts.map { |post| Dto::PostSerializer.serialize(post) }
      }
    end

    def panko(posts)
      Panko::ArraySerializer.new(posts, each_serializer: PankoSerializers::PostSerializer).to_json
    end

    def oj(posts)
      Oj.dump(posts, mode: :compat)
    end
  end
end
