require 'rails_helper'

RSpec.describe CheckinsHelper, type: :helper do
  let(:timezone) { 'Asia/Ho_Chi_Minh' }

  before do
    allow(Figaro.env).to receive(:timezone).and_return(timezone)
  end

  describe '#date_labels' do
    it 'returns last 10 days' do
      expect(helper.date_labels.count).to eq 10
      expect(helper.date_labels.last).to eq Date.today.strftime(DATE_FORMAT)
    end
  end

  describe '#checkin_times' do
    let(:hour_in_float) { 11.11 }

    before do
      allow(helper).to receive(:get_checkin_hour_of_date).and_return(hour_in_float)
    end

    it 'returns array of checkin hour' do
      expect(helper.checkin_times(Checkin.all)).to eq [hour_in_float] * 10
    end
  end

  describe '#get_checkin_hour_of_date' do
    let(:created_at) { Time.now }
    let(:response) { helper.get_checkin_hour_of_date(Checkin.all, created_at) }

    context 'no checkin in the date' do
      it 'returns 0' do
        expect(response).to eq 0
      end
    end

    context 'has checkin in the date' do
      let!(:checkin) { create(:checkin, created_at: created_at) }
      let(:hour_in_float) { 22.222 }

      before do
        allow_any_instance_of(Checkin).to receive(:get_hour_in_float).and_return(hour_in_float)
      end

      it 'returns hour of checkin' do
        expect(response).to eq hour_in_float
      end
    end
  end
end
