class CreatePetInfos < ActiveRecord::Migration[8.0]
  def change
    create_table :pets_infos do |t|
      t.references :pet, null: false, foreign_key: { to_table: :pets }
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      
      t.string :channel
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
