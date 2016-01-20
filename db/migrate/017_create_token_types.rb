class CreateTokenTypes < ActiveRecord::Migration
  def change
    create_table :token_types do |t|

      t.timestamps null: false
    end
  end
end
