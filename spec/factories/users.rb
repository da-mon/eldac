FactoryGirl.define do

  factory :user do
    fname 'First'
    lname 'Last'
    email 'user@example.com'
    email_valid true
    disabled false
    deleted false
    last_login nil
    password 'changeme'
    password_confirmation 'changeme'

    trait :valid_user do
      fname { Faker::Name.first_name }
      lname { Faker::Name.last_name }
      email { Faker::Internet.email }
    end

  end

end
