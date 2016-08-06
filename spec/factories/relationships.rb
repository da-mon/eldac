FactoryGirl.define do

  factory :relationship do
    name 'Relationship'

    trait :valid_relationship do
      name { Faker::Lorem.word }
    end
    trait :owner do
      name 'owner'
    end
  end

end
