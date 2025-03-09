class CreateBans < ActiveRecord::Migration[8.0]
  def change
    create_table :bans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reason
      t.datetime :banned_at

      t.timestamps
    end
  end
end
