class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|

      t.timestamps null: false
    end
  end
end
