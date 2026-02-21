require "benchmark/ips"
require "benchmark/memory"

namespace :benchmark do
  desc "Benchmark JSON serialization strategies"
  task serialization: :environment do
    posts = Post.includes(user: {}, comments: :user).limit(1_000).to_a
    puts "Benchmarking with #{posts.size} posts (with user and comments:user loaded)"

    Benchmark.ips do |x|
      x.config(time: 5, warmup: 2)

      x.report("as_json") do
        ActiveSupport::JSON.encode(PostSerializationStrategies.as_json(posts))
      end

      x.report("dto_manual") do
        ActiveSupport::JSON.encode(PostSerializationStrategies.dto(posts))
      end

      x.report("panko") do
        PostSerializationStrategies.panko(posts)
      end

      x.report("oj_native") do
        PostSerializationStrategies.oj(posts)
      end

      x.compare!
    end

    Benchmark.memory do |x|
      x.report("as_json") do
        ActiveSupport::JSON.encode(PostSerializationStrategies.as_json(posts))
      end

      x.report("dto_manual") do
        ActiveSupport::JSON.encode(PostSerializationStrategies.dto(posts))
      end

      x.report("panko") do
        PostSerializationStrategies.panko(posts)
      end

      x.report("oj_native") do
        PostSerializationStrategies.oj(posts)
      end

      x.compare!
    end
  end
end
