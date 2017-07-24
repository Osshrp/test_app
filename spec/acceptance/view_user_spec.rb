require 'rails_helper'

feature 'View user', %q{
  In order to check the required user,
  I need to ba able
  to view the users attributes
} do
  given!(:user) { create(:user) }

  context 'Authenticated user' do
    before { sign_in(user) }
    scenario 'sees the user attributes' do

      expect(page).to have_content user.email
      expect(page).to have_content user.name
      expect(page).to have_content user.birth_date
      expect(page).to have_content user.bio
    end
  end

  context 'Unauthenticated user' do
    scenario 'sees the user attributes' do
      visit user_path(user)

      expect(page).to_not have_content user.email
      expect(page).to_not have_content user.name
      expect(page).to_not have_content user.birth_date
      expect(page).to_not have_content user.bio
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end
end
