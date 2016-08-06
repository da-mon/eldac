
include FactoryGirl::Syntax::Methods

%w{ text textarea radio select image checkbox date datetime calculated }.sort.each do |n|
  create(:field_type, name: n)
end
puts "#{FieldType.count} field types created"
text = FieldType.where(name: 'text').first

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

page = create(:page, form: form, name: 'Page 1')
puts "#{Page.count} pages created"

section = create(:section, page: page, name: 'Section 1')
puts "#{Section.count} sections created"

field = create(:field, section: section, name: 'Field 1', field_type: text)
puts "#{Field.count} fields created"

survey = create(:survey, project: project, name: 'Survey 1')
puts "#{Survey.count} surveys created"

survey_form = create(:survey_form, survey: survey, form: form)
puts "#{SurveyForm.count} survey forms created"
