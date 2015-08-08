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
    let(:checkin) { build(:checkin) }
    let(:time_local) { DateTime.parse('2015-08-08 03:48:58 -0700') }

    before do
      allow(checkin).to receive(:created_at_local_time).and_return time_local
    end
    
    it 'return correct time in float' do
      expect(checkin.get_hour_in_float).to eq (3 + 48 / 60.0)
    end
  end

  describe '#created_at_local_time' do
    let(:time_zone) { 'Asia/Ho_Chi_Minh' }
    let(:checkin) { build(:checkin, created_at: created_at) }
    let(:created_at) { DateTime.parse('2015-08-08 03:48:58 -0700') }

    before do
      expect(Figaro.env).to receive(:timezone).and_return(time_zone)
    end

    it 'returns correct time in timezone' do
      expect(checkin.created_at_local_time.to_s).to eq "2015-08-08 17:48:58 +0700"
    end
  end
end
