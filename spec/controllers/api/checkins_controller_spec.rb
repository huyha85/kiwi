require 'rails_helper'

RSpec.describe Api::CheckinsController, type: :controller do
  describe 'POST create' do
    let(:response_json) { JSON.parse(response.body) }
    context 'with valid params' do
      let(:email) { Faker::Internet.email }
      let(:valid_params) {
        { email: email }
      }

      context 'with success toggle_checkin' do
        let(:checkin) { create(:checkin) }
        it 'returns timestamp of checkin' do
          expect(Checkin).to receive(:toggle_checkin).with(email).and_return(checkin)
          post :create, valid_params
          expect(response).to have_http_status(:ok)
          expect(response_json['timestamp']).to eq checkin.created_at.to_i
        end
      end

      context 'with unsuccess toggle_checkin' do
        it 'returns bad_request response' do
          expect(Checkin).to receive(:toggle_checkin).with(email).and_return(nil)
          post :create, valid_params
          expect(response).to have_http_status(:bad_request)
          expect(response_json['error']).to eq 'Invalid user email'
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { {} }

      it 'returns error' do
        expect(Checkin).not_to receive(:toggle_checkin)
        post :create, invalid_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end