class CreateFieldOpts < ActiveRecord::Migration

  def change
    create_table :field_opts do |t|
      t.references :field, index: true, foreign_key: true
      t.string :name, index: true, limit: 64
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :field_opts, [:field_id, :name], unique: true
  end

end
