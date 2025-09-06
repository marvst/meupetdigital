class CreatePetUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :pet_users do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
