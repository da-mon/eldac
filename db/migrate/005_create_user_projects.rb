class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|

      t.timestamps null: false
    end
  end
end
