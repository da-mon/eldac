class CreateSections < ActiveRecord::Migration

  def change
    create_table :sections do |t|
      t.references :page, index: true, foreign_key: true
      t.string :name, index: true, limit: 64
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :sections, [:page_id, :name], unique: true
  end

end
