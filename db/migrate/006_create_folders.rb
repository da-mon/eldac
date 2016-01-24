class CreateFolders < ActiveRecord::Migration

  def change
    create_table :folders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, :limit => 64, :null => false
      t.string :fg, :null => false, :default => '000000', :limit => 6
      t.string :bg, :null => false, :default => 'ffffff', :limit => 6
      t.boolean :collapsed, :null => false, :default => false
      t.integer :position, index: true, :null => false, :default => 0
    end
  end
  
end
