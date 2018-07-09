class CreateAuthentications < ActiveRecord::Migration[5.2]
  def change
    create_table :authentications do |t|
      t.references :user, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.string :access_token, null: false

      t.timestamps
    end
  end
end
