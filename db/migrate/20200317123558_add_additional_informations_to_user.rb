class AddAdditionalInformationsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :name_display, :boolean
    add_column :users, :department, :integer
  end
end
