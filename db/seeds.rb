
%w{ text textarea radio select image checkbox date datetime calculated }.sort.each{ |n|
  FieldType.create!(:name => n)
}

%w{ validate_email }.sort.each{ |n|
  TokenType.create!(:name => n)
}

%w{ owner }.sort.each{ |n|
  Relationship.create!(:name => n)
}

User.create!(
  :fname => 'Greg',
  :lname => 'Donald',
  :email => 'gdonald@gmail.com',
  :password => 'changeme',
  :password_confirmation => 'changeme',
  :email_valid => true
)
