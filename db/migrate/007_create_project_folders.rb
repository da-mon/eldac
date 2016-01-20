class CreateProjectFolders < ActiveRecord::Migration
  def change
    create_table :project_folders do |t|

      t.timestamps null: false
    end
  end
end
