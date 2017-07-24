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

  describe 'GET #new' do
    sign_in_user(admin: true)
    before { get :new }
    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context 'admin tries to update user' do
      context 'with valid attributes' do
        sign_in_user(admin: true)

        it 'creates user' do
          expect { post :create, params: { user: attributes_for(:user) } }
            .to change(User, :count).by(1)
        end
      end
    end

    context 'ordinary user tries to update user' do
      sign_in_user

      it 'creates user' do
        expect { post :create, params: { user: attributes_for(:user) } }
          .to_not change(User, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user) { create(:user) }

    context 'admin tries to update user' do
      sign_in_user(admin: true)
      context 'with valid attributes' do
        sign_in_user(admin: true)
        it 'assigns the requested usert to @user' do
          patch :update, params: { id: user, user: attributes_for(:user) }
          expect(assigns(:user)).to eq user
        end

        it 'change user attributes' do
          patch :update, params: { id: user,
            user: { bio: 'new_bio', email: 'new_email@test.com' } }
          user.reload
          expect(user.email).to eq 'new_email@test.com'
          expect(user.bio).to eq 'new_bio'
        end
      end
    end

    context 'ordinary user tries to update user' do
      sign_in_user
      it 'change user attributes' do
        patch :update, params: { id: user,
          user: { bio: 'new_bio', email: 'new_email@test.com' } }
        user.reload
        expect(user.email).to_not eq 'new_email@test.com'
        expect(user.bio).to_not eq 'new_bio'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    context 'admin tries to delete user' do
      sign_in_user(admin: true)

      it 'deletes user' do
        expect { delete :destroy, params: { id: user } }
          .to change(User, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, params: { id: user }
        expect(response).to redirect_to admin_users_path
      end
    end

    context 'ordinary user tries to delete user' do
      sign_in_user
      it 'does not deletes user' do
        expect { delete :destroy, params: { id: user } }
          .to_not change(User, :count)
      end

      it 'redirects to users index view' do
        delete :destroy, params: { id: user }
        expect(response).to redirect_to users_path
      end
    end
  end
end
