class CreateRecords < ActiveRecord::Migration

  def change
    create_table :records do |t|
      t.references :user, index: true, foreign_key: true
      t.references :form, index: true, foreign_key: true
      t.references :survey, index: true, foreign_key: true, null: true
      t.timestamps null: false
    end
  end

end
