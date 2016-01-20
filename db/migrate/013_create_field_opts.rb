class CreateFieldOpts < ActiveRecord::Migration
  def change
    create_table :field_opts do |t|

      t.timestamps null: false
    end
  end
end
