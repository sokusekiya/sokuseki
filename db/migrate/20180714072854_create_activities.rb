class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :authentication, foreign_key: true
      t.string :activity_id, null: false
      t.string :activity_type, null: false
      t.datetime :acted_at, null: false
      t.jsonb :original_data

      t.timestamps
    end

    add_index :activities, [:activity_id, :activity_type], unique: true
    add_index :activities, :acted_at
  end
end
