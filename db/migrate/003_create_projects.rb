class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.string :name, index: true, :limit => 64, :null => false
      t.boolean :deleted, index: true, :default => false
    end
  end

end
