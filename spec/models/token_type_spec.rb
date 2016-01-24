require 'rails_helper'

RSpec.describe TokenType, type: :model do

  let(:valid_token_type){ create(:token_type, :valid_token_type) }

  describe 'valid token_type' do
    it 'has a valid factory' do
      expect(valid_token_type).to be_valid
    end
  end

end
