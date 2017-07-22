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
end
