# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { User.create!(email: 'test@example.com', password: 'password1234', role: 0) }

  describe 'GET #show' do
    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :show
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before do
        # Devise test helper to log in
        sign_in user
        get :show
      end

      it 'responds successfully' do
        expect(response).to be_successful
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'loads the current user into @user' do
        expect(assigns(:user)).to eq(user)
      end
    end
  end
end
