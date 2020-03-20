class ChangeDataTypeForDepartment < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :department, :string
  end

  def down
    change_column :users, :department, :integer, using: 'department::integer'
  end
end
