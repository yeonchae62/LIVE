# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MainController do
  let(:user1) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }
  let(:user2) { User.create!(email: 'test2@example.com', password: 'password1234', role: 2) }

  before do
    sign_in user2
  end

  describe 'GET #index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_successful # or use expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #user_management' do
    context 'when the user is an admin' do
      it 'assigns @users' do
        get :user_management
        expect(assigns(:users)).to eq([user2])
      end

      it 'renders the user_management template' do
        get :user_management
        expect(response).to render_template('user_management')
      end
    end

    context 'when the user is not an admin' do
      before { sign_in user1 }

      it 'does not allow access' do
        get :user_management
        expect(flash[:alert]).to eq('You are not authorized to view this page.')
      end

      it 'redirects to root_path' do
        get :user_management
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #change_role' do
    context 'when the user is an admin' do
      it "updates the user's role" do
        post :change_role, params: { user_id: user2.id, role: 'moderator' }
        user2.reload
        expect(user2.role).to eq('moderator')
      end

      it 'redirects to the user_management path' do
        post :change_role, params: { user_id: user2.id, role: 'moderator' }
        expect(response).to redirect_to(user_management_path)
      end

      it 'sets a flash notice indicating the user role was updated successfully' do
        post :change_role, params: { user_id: user2.id, role: 'moderator' }
        expect(flash[:notice]).to eq('User role updated successfully.')
      end
    end

    context 'when the user is not an admin' do
      before { sign_in user1 }

      it 'does not allow updating roles' do
        post :change_role, params: { user_id: user1.id, role: 'moderator' }
        expect(user1.reload.role).not_to eq('moderator')
      end

      it 'redirects to the root path' do
        post :change_role, params: { user_id: user1.id, role: 'moderator' }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash alert indicating unauthorized access' do
        post :change_role, params: { user_id: user1.id, role: 'moderator' }
        expect(flash[:alert]).to eq('You are not authorized to view this page.')
      end
    end
  end
end
