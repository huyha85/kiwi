require 'rails_helper'

RSpec.describe Api::CheckinsController, type: :controller do
  describe 'POST create' do
    context 'with valid params' do
      let(:email) { Faker::Internet.email }
      let(:valid_params) {
        { email: email }
      }

      it 'toggles perform method in Checkin model' do
        expect(Checkin).to receive(:toggle_checkin).with(email).and_call_original
        post :create, valid_params
        expect(response).to have_http_status(:ok)
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