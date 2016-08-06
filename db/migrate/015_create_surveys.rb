class CreateSurveys < ActiveRecord::Migration

  def change
    create_table :surveys do |t|
      t.references :project, index: true, foreign_key: true
      t.string :name, null: false, index: true, limit: 64
      t.boolean :active, index:true, null: false, default: false
      t.integer :records_count, null: false, default: 0
      t.integer :position, index: true, null: false, default: 0
      t.timestamps null: false
    end
  end

end
