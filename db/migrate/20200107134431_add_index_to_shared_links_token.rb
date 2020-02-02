class AddIndexToSharedLinksToken < ActiveRecord::Migration[6.0]
  def change
    add_index :shared_links, :token, unique: true
  end
end
