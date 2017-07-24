require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list(:user, 2) }
  describe 'GET #index' do

    before { get :index }
    it 'populates an array of all users' do
      expect(assigns(:users)).to match_array(users)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    context 'unauthenticated user tries to get#show' do
      before { get :show, params: { id: users.first } }

      it 'does not assign requested question to @question' do
        expect(assigns(:user)).to_not eq users.first
      end

      it 'does not renders show view' do
        expect(response).to_not render_template :show
      end
    end

    context 'authenticated user tries to get#show' do
      sign_in_user
      before { get :show, params: { id: users.first } }

      it 'assigns requested question to @question' do
        expect(assigns(:user)).to eq users.first
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end
end
