
FactoryGirl.define do

  factory :project_folder do
    user { create(:user, :valid_user) }
    project { create(:project, :valid_project) }
    folder { create(:folder, :valid_folder) }

    trait :valid_project_folder do
    end
  end

end
