class CreateTokenTypes < ActiveRecord::Migration

  def change
    create_table :token_types do |t|
      t.string :name, null: false, limit: 32
    end
    add_index :token_types, :name, unique: true
  end

end
