class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.belongs_to :commitment, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
