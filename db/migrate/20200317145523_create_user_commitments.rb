class CreateUserCommitments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_commitments do |t|
			t.belongs_to :user, index: true
			t.belongs_to :commitment, index: true
      t.timestamps
    end
  end
end
