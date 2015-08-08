require 'rails_helper'

RSpec.describe CheckinsController, type: :controller do

  describe 'GET index' do
    let(:user) { create(:user) }
    let(:user_id) { nil }
    let!(:user_checkins) { create_list(:checkin, user_checkins_num, user_id: user.id) }
    let!(:other_checkins) { create_list(:checkin, other_checkins_num) }
    let(:user_checkins_num) { 3 }
    let(:other_checkins_num) { 2 }
    let(:checkins_result) { assigns(:checkins) }
    let(:user_result) { assigns(:user) }

    let(:params) do
      {
        user_id: user_id
      }
    end

    before do
      get :index, params
    end

    it 'returns success' do
      expect(response).to be_success
    end

    it 'returns all users' do
      expect(assigns(:users).count).to eq User.count 
    end

    context 'with valid user_id' do
      let(:user_id) { user.id.to_s }

      it 'returns the user' do
        expect(user_result).to eq user
      end

      it 'returns all checkins of user' do
        expect(checkins_result.count).to eq user_checkins_num
      end
    end

    context 'with invalid user_id' do
      let(:user_id) { 'invalid' }

      it 'returns no users' do
        expect(user_result).to be_blank
      end

      it 'returns no checkins' do
        expect(checkins_result).to be_blank
      end
    end

    context 'with blank user_id' do
      it 'returns no users' do
        expect(user_result).to be_blank
      end

      it 'returns all checkins' do
        expect(checkins_result.count).to eq (user_checkins_num + other_checkins_num)
      end
    end
  end
end
