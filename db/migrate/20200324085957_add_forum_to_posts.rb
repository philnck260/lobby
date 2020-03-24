class AddForumToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :forum, index: true
  end
end
