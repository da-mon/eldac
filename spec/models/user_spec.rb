
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:valid) { create(:user, :valid) }

  describe "valid user" do

    it 'has a valid factory' do
      expect(valid).to be_valid
    end

    it 'can authenticate' do
      user = User.authenticate(valid.email, '')
      expect(user).to eq(nil)
      user = User.authenticate(valid.email, nil)
      expect(user).to eq(nil)
      user = User.authenticate('', nil)
      expect(user).to eq(nil)
      user = User.authenticate(nil, nil)
      expect(user).to eq(nil)
      user = User.authenticate(valid.email, 'changeme')
      expect(user).to eq(valid)
    end

    it 'has a fullname' do
      expect(valid.fullname).to eq('First Last')
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

    it 'should have a valid first name' do
      foo = build(:user, fname: 'x' * 33)
      expect(foo).to be_invalid
      foo = build(:user, fname: '')
      expect(foo).to be_invalid
      foo = build(:user, fname: nil)
      expect(foo).to be_invalid
    end

    it 'should have a valid last name' do
      foo = build(:user, lname: 'x' * 33)
      expect(foo).to be_invalid
      foo = build(:user, lname: '')
      expect(foo).to be_invalid
      foo = build(:user, lname: nil)
      expect(foo).to be_invalid
    end

  end

end
