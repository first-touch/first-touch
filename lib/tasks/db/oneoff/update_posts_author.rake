namespace :db do
  namespace :oneoff do
    desc 'update posts author to match polymorphic'
    task update_posts_author: :environment do
      Post.all.each do |post|
        post.author_id = post.user_id
        post.author_type = 'User'
        post.save
      end
    end
  end
end
