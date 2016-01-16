
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:valid) { create(:user, :valid) }

  describe "valid user" do

    it 'has a valid factory' do
      expect(valid).to be_valid
    end

    it 'can authenticate' do
      user = User.authenticate(valid.email, 'changeme')
      expect(user).to eq(valid)
    end

    it 'has a fullname' do
      expect(valid.fullname).to eq('First Last')
    end

    it 'requires a valid last name' do
      valid.lname = nil
      expect(valid).to be_invalid
      valid.lname = ''
      expect(valid).to be_invalid
    end

    it 'requires a valid first name' do
      valid.fname = nil
      expect(valid).to be_invalid
      valid.fname = ''
      expect(valid).to be_invalid
    end

    it 'requires a valid email' do
      valid.email = nil
      expect(valid).to be_invalid
      valid.email = ''
      expect(valid).to be_invalid
      valid.email = 'x@'
      expect(valid).to be_invalid
      valid.email = '@x'
      expect(valid).to be_invalid
    end

    it 'requires a unique email' do
      dupe = build(:user, email: valid.email)
      expect(dupe).to be_invalid
    end

    it 'should have downcased email' do
      foo = create(:user, email: 'Foo@baR.Com')
      expect(foo.email).to eq('foo@bar.com')
    end

  end

end
