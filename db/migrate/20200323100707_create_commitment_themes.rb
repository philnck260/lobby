class CreateCommitmentThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :commitment_themes do |t|
			t.belongs_to :commitment, index: true
			t.belongs_to :theme, index: true
      t.timestamps
    end
  end
end
