class CreateForms < ActiveRecord::Migration

  def change
    create_table :forms do |t|
      t.references :project, index: true, foreign_key: true
      t.string :name, null: false, index: true, limit: 64
      t.integer :records_count, null: false, default: 0
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :forms, [:project_id, :name], unique: true
  end

end
