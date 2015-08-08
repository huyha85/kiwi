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

  describe '#get_hour_in_float' do
    let(:checkin) { create(:checkin, created_at: created_at) }
    let(:created_at) { DateTime.parse('2015-08-08 03:48:58 -0700') }
    
    it 'return correct time in float' do
      expect(checkin.get_hour_in_float).to eq (10 + 48 / 60.0)
    end
  end
end
