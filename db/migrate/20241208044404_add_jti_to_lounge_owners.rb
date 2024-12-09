class AddJtiToLoungeOwners < ActiveRecord::Migration[7.1]
  def change
    add_column :lounge_owners, :jti, :string, null: false
    add_index :lounge_owners, :jti, unique: true
  end
end
