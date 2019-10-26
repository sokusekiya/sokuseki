class CreateSharedLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :shared_links do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :expired_at
      t.string :on
      t.string :token

      t.timestamps
    end
  end
end
