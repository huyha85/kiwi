require 'rails_helper'

RSpec.describe Api::CheckinsController, type: :controller do
  describe 'POST create' do
    let(:response_json) { JSON.parse(response.body) }
    let(:random) { rand(1000..9999) }
    let(:token_params) { { random: random, token: token } }
    let(:email) { Faker::Internet.email }
    let(:token) { Digest::SHA256.hexdigest("/api/checkin#{email}#{random}") }
    let(:request_params) {
      { email: email }.merge(token_params)
    }

    context 'with valid token' do
      context 'with valid params' do
        context 'with success toggle_checkin' do
          let(:checkin) { create(:checkin) }
          it 'returns timestamp of checkin' do
            expect(Checkin).to receive(:toggle_checkin).with(email).and_return(checkin)
            post :create, request_params
            expect(response).to have_http_status(:ok)
            expect(response_json['timestamp']).to eq checkin.created_at.to_i
          end
        end

        context 'with unsuccess toggle_checkin' do
          it 'returns bad_request response' do
            expect(Checkin).to receive(:toggle_checkin).with(email).and_return(nil)
            post :create, request_params
            expect(response).to have_http_status(:bad_request)
            expect(response_json['error']).to eq 'Invalid user email'
          end
        end
      end

      context 'with invalid params' do
        let(:request_params) { token_params }

        it 'returns error' do
          expect(Checkin).not_to receive(:toggle_checkin)
          post :create, request_params
          expect(response).to have_http_status(:bad_request)
          expect(response_json['error']).to eq 'Required parameter missing: email'
        end
      end
    end

    context 'with invalid token' do
      let(:token) { 'invalid_token' }
      it 'returns error' do
        post :create, request_params
        expect(response).to have_http_status(:unauthorized)
        expect(response_json['error']).to eq 'Unauthorized'
      end
    end
  end
end