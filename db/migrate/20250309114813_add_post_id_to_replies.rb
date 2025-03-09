class AddPostIdToReplies < ActiveRecord::Migration[8.0]
  def change
    add_column :replies, :post_id, :integer
  end
end
