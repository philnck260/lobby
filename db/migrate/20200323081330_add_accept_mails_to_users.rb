class AddAcceptMailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accept_mails, :boolean, :default => false
  end
end
