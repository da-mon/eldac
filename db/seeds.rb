
include FactoryGirl::Syntax::Methods

%w{ text textarea radio select image checkbox date datetime calculated }.sort.each do |n|
  create(:field_type, name: n)
end
puts "#{FieldType.count} field types created"

%w{ validate_email }.sort.each do |n|
  create(:token_type, name: n)
end
puts "#{TokenType.count} token types created"

%w{ owner }.sort.each do |n|
  create(:relationship, name: n)
end
puts "#{Relationship.count} relationships created"

user = create(:user, 
  fname: 'Greg',
  lname: 'Donald',
  email: 'gdonald@gmail.com',
  password: 'changeme',
  password_confirmation: 'changeme',
  email_valid: true
)
puts "#{User.count} users created"

project = create(:project, name: Faker::Name.title)
up = create(:user_project, user: user, project: project, relationship: Relationship.owner)

puts "#{Project.count} projects created"
puts "#{UserProject.count} user projects created"

folder = create(:folder, user: user, name: 'My Projects', collapsed: true, fg: 'ffffff', bg: 'cc0000')
create(:project_folder, user: user, project: project, folder: folder)

puts "#{ProjectFolder.count} project folders created"

form = create(:form, project: project, name: 'Form 1')
puts "#{Form.count} forms created"
