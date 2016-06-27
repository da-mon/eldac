class CreateFieldTypes < ActiveRecord::Migration

  def change
    create_table :field_types do |t|
      t.string :name, null: false, limit: 32
    end
    add_index :field_types, :name, unique: true
  end

end
