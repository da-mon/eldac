class CreateFieldCalcs < ActiveRecord::Migration

  def change
    create_table :field_calcs do |t|
      t.references :field, index: true, foreign_key: true
      t.text :content, limit: 1024
    end
  end

end
