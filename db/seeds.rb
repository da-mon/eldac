
%w{ text textarea radio select image checkbox date datetime calculated }.sort.each{ |n|
  FieldType.create!(:name => n)
}

%w{ validate_email }.sort.each{ |n|
  TokenType.create!(:name => n)
}

%w{ owner }.sort.each{ |n|
  Relationship.create!(:name => n)
}

user = User.create!(
  :fname => 'Greg',
  :lname => 'Donald',
  :email => 'gdonald@gmail.com',
  :password => 'changeme',
  :password_confirmation => 'changeme',
  :email_valid => true
)

37.times do
  p = Project.create!( name: Faker::Name.title )
  UserProject.create!( user: user, project: p, relationship: Relationship.owner )
end

5.times do
  f = Folder.create!( user: user, name: Faker::Name.last_name, collapsed: true )
  UserProject.where( user: user ).each do |up|
    ProjectFolder.create!( user: user, project: up.project, folder: f ) if (up.id + f.id) % 2 == 0
  end
end

4.times do
  p = Project.create!( name: Faker::Name.title )
  UserProject.create!( user: user, project: p, relationship: Relationship.owner )
end
