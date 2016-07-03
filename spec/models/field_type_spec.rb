require 'rails_helper'

RSpec.describe FieldType, type: :model do

  let(:field_type) { create(:field_type) }

  describe 'valid field type' do
    it 'has a valid factory' do
      expect(field_type).to be_valid
    end

    it 'requires a valid name' do
      field_type.name = nil
      expect(field_type).to_not be_valid    	
      expect(field_type.errors[:name]).to_not be_nil
    end

    it 'responds to to_s' do
      expect(field_type.to_s).to eq(field_type.name)
    end

  end
end
