require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:users) { create_list(:user, 2) }
  describe 'GET #index' do

    context 'ordinary user tries to get#index' do
      sign_in_user
      before { get :index }
      it 'does not populate an array of all users' do
        expect(assigns(:users)).to_not match_array(User.all)
      end
      it 'does not render index view' do
        expect(response).to_not render_template :index
      end
    end

    context 'admin user tries to get#index' do
      sign_in_user(admin: true)
      before { get :index }
      it 'populates an array of all users' do
        expect(assigns(:users)).to match_array(User.all)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do

    context 'ordinary user tries to get#show' do
      sign_in_user
      before { get :show, params: { id: users.first } }

      it 'does not assign requested user to @user' do
        expect(assigns(:user)).to_not eq users.first
      end

      it 'does not renders show view' do
        expect(response).to_not render_template :show
      end
    end

    context 'admin user tries to get#show' do
      sign_in_user(admin: true)
      before { get :show, params: { id: users.first } }

      it 'assigns requested user to @user' do
        expect(assigns(:user)).to eq users.first
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end
end
