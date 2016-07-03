require 'rails_helper'

RSpec.describe FieldOpt, type: :model do

	let(:project) { create(:project) }
	let(:form) { create(:form, project: project) }
	let(:page) { create(:page, form: form) }
	let(:field_type) { create(:field_type) }
	let(:section) { create(:section, page: page) }
	let(:field) { create(:field, section: section) }
	let(:field_opt) { create(:field_opt, field: field) }

	describe 'valid field opt' do
		it 'has a valid factory' do
      expect(field_opt).to be_valid
    end

    it 'requires a name' do
    	field_opt.name = nil
      expect(field_opt).to_not be_valid    	
    end

    it 'responds to str' do
    	expect(field_opt.to_s).to eq(field_opt.name)
    end
	end
end
