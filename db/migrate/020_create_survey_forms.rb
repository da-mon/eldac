class CreateSurveyForms < ActiveRecord::Migration
  def change
    create_table :survey_forms do |t|
      t.integer :survey_id
      t.integer :form_id

      t.timestamps null: false
    end
  end
end
