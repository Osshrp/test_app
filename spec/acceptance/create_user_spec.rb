require 'rails_helper'

feature 'Create user', %q{
  In order to create new user
  as an admin
  I need to be able to create user
} do

  given(:admin) { create(:user, admin: true) }
  given(:user) { create(:user) }

  scenario 'Admin creates question' do
    sign_in(admin)

    click_on 'Create new user'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Name', with: 'Bill'
    fill_in 'Birth date', with: '2017-11-03'
    fill_in 'Bio', with: 'string'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Create'

    within '.user' do
      expect(page).to have_content 'test@test.com'
      expect(page).to have_content 'Bill'
      expect(page).to have_content '2017-11-03'
      expect(page).to have_content 'string'
    end
  end
end
