class CreateUserProjects < ActiveRecord::Migration

  def change
    create_table :user_projects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.references :relationship, index: true, foreign_key: true
    end
    add_index :user_projects, [:user_id, :project_id, :relationship_id], unique: true, :name => :user_proj_rel
  end

end
