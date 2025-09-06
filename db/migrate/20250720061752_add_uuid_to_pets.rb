class AddUuidToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :uuid, :string
    add_index :pets, :uuid, unique: true
  end
end
