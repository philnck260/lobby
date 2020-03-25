class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.text :content
      t.belongs_to :user, index: true 
      t.belongs_to :post, index: true 


      t.timestamps
    end
  end
end
