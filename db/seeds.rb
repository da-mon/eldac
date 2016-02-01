
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

17.times do
  p = Project.create!( name: Faker::Name.title )
  UserProject.create!( user: user, project: p, relationship: Relationship.owner )
end

fg = %w(000000 ffffff ffffff ffffff ffffff ffffff)
bg = %w(ffffff 337ab7 5cb85c 5bc0de f0ad4e d9534f)
6.times do |x|
  f = Folder.create!( user: user, name: Faker::Name.last_name, collapsed: true, fg: fg[x], bg: bg[x] )
  UserProject.where( user: user ).each do |up|
    ProjectFolder.create!( user: user, project: up.project, folder: f ) if (up.id + f.id) % 2 == 0
  end
end

3.times do
  f = Form.create!( project: Project.first, name: Faker::Name.last_name )
end
