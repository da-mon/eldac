
FactoryGirl.define do

  factory :project do
    name 'Project'

    trait :valid_project do
      name { Faker::Lorem.word.titleize }
    end
  end

end
