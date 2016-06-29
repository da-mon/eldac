class CreateFieldTypes < ActiveRecord::Migration

  def change
    create_table :field_types do |t|
      t.string :name, null: false, limit: 32
      t.integer :fields_count, null: false, default: 0
    end
    add_index :field_types, :name, unique: true
  end

end
