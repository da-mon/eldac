class CreateFieldCalcs < ActiveRecord::Migration
  def change
    create_table :field_calcs do |t|

      t.timestamps null: false
    end
  end
end
