require 'rails_helper'

RSpec.describe Checkin, type: :model do
  describe '#toggle_checkin' do
    let(:response) { Checkin.toggle_checkin(email) }
    context 'with whitelisted domain email' do
      let!(:user) { create(:user, email: email) }
      let(:email) { "#{Faker::Internet.user_name}@#{ENV['email_domain']}" }

      context 'with no checkin today' do
        let!(:checkin) { Checkin.create(user: user) }
        before { checkin.set(created_at: 1.day.ago) }
        it 'returns new checkin' do
          expect {
            expect(response).to be_is_a(Checkin)
          }.to change(user.checkins, :count).by(1)
        end
      end

      context 'with existing checkin today' do
        let!(:checkin) { Checkin.create(user: user) }
        it 'returns existing checkin' do
          expect {
            expect(response).to eq checkin
          }.not_to change(user.checkins, :count)
        end
      end
    end

    context 'with unwhitelisted domain email' do
      let(:email) { "user@other#{ENV['email_domain']}" }

      it 'returns nil' do
        expect(response).to eq nil
      end
    end
  end
end
