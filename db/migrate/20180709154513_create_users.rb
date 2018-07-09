class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :avatar_url, null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
