now = Time.current

Comment.delete_all
Post.delete_all
User.delete_all

users_payload = 100.times.map do |i|
  {
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    created_at: now,
    updated_at: now
  }
end
users_payload.each_slice(1_000) { |batch| User.insert_all(batch) }
user_ids = User.order(:id).pluck(:id)

posts_payload = 5_000.times.map do |i|
  {
    title: "Post #{i + 1}",
    body: "Body for post #{i + 1}",
    user_id: user_ids.sample,
    created_at: now,
    updated_at: now
  }
end
posts_payload.each_slice(1_000) { |batch| Post.insert_all(batch) }
post_ids = Post.order(:id).pluck(:id)

comments_payload = 20_000.times.map do |i|
  {
    body: "Comment #{i + 1}",
    post_id: post_ids.sample,
    user_id: user_ids.sample,
    created_at: now,
    updated_at: now
  }
end
comments_payload.each_slice(1_000) { |batch| Comment.insert_all(batch) }
