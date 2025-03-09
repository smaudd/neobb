class CreatePersonalizationData < ActiveRecord::Migration[8.0]
  def change
    create_table :personalization_data do |t|
      t.references :user, null: false, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
