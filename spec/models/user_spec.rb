require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe '#with_whitelist_domain_email' do
    let(:response) { User.with_whitelist_domain_email(email) }

    context 'with invalid domain' do
      let(:email) { "user@other#{ENV['email_domain']}" }
      it 'returns nil' do
        expect(response).to eq nil
      end
    end

    context 'with valid domain' do
      let(:email) { "#{Faker::Internet.user_name}@#{ENV['email_domain']}" }

      context 'with existing user' do
        let!(:user) { create(:user, email: email) }

        it 'returns existing user' do
          expect {
            expect(response).to eq user
          }.not_to change(User, :count)
        end
      end

      context 'with no user' do
        it 'returns new user' do
          expect {
            expect(response).to be_is_a(User)
          }.to change(User, :count).by(1)
        end
      end
    end
  end
end
