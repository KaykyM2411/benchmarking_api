class BenchmarksController < ApplicationController
  before_action :load_posts

  def as_json_strategy
    render json: PostSerializationStrategies.as_json(@posts)
  end

  def dto
    render json: PostSerializationStrategies.dto(@posts)
  end

  def panko
    render plain: PostSerializationStrategies.panko(@posts), content_type: "application/json"
  end

  def oj
    render plain: PostSerializationStrategies.oj(@posts), content_type: "application/json"
  end

  private

  def load_posts
    @posts = Post.includes(user: {}, comments: :user).limit(1_000)
  end
end
