
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

    trait :valid do
      email 'valid@example.com'
    end

  end

end
