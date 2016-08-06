class CreateSurveyForms < ActiveRecord::Migration

  def change
    create_table :survey_forms do |t|
      t.references :survey
      t.references :form
    end
  end

end
