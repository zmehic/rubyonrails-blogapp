class MoveBodyToActionText < ActiveRecord::Migration[7.2]
  def change
    BlogPost.all.find_each do |blog_post|
      BlogPost.update(content: blog_post.body)
    end
    remove_column :blog_posts, :body
  end
end
