class CreateAuthTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
    add_index :auth_tokens, :token, unique: true
  end
end
