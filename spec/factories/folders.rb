FactoryGirl.define do

  factory :folder do
    user { create(:user, :valid_user) }
    name 'Folder'

    trait :valid_folder do
      name 'Valid Folder'
    end
  end

end
