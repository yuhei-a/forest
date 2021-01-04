class RemovePostsImageIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :post_image_id, :integer
  end
end
