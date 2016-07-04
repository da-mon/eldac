class CreateValues < ActiveRecord::Migration

  def change
    create_table :values do |t|
      t.references :record, index: true, foreign_key: true
      t.references :field, index: true, foreign_key: true
      t.text :content, limit: 4096
      t.timestamps null: false
    end
    add_index :values, [:record_id, :field_id], unique: true
  end

end
