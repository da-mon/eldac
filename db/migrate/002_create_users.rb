
class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 64
      t.string :p_salt, limit: 80
      t.string :p_hash, limit: 80
      t.string :fname, limit: 32
      t.string :lname, limit: 32
      t.boolean :email_valid, null: false, index: true, default: false
      t.boolean :disabled, null: false, index: true, default: false
      t.boolean :deleted, null: false, index: true, default: false
      t.timestamp :last_login, index: true, default: nil
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end

end
