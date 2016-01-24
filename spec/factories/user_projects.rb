
FactoryGirl.define do

  factory :user_project do
    user { create(:user, :valid_user) }
    project { create(:project, :valid_project, name: Faker::Lorem.word.titleize) }
    relationship { create(:relationship, :owner, name: Faker::Lorem.word.titleize) }

    trait :valid_user_project do
    end
  end

end
