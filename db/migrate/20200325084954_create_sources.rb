class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
			t.string :url
			t.string :title
			t.text :description
			t.string :category
			t.string :media
			t.references :sourceable, polymorphic: true
      t.timestamps
    end
  end
end
