class AddColumnUsernameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
  end
end
