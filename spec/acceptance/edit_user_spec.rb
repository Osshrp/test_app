require 'rails_helper'

feature 'Edit user', %q{
  In order to change new user
  as an admin
  I need to be able to edit user
} do

  given(:admin) { create(:user, admin: true) }
  given!(:user) { create(:user) }

  scenario 'Admin edits question' do
    sign_in(admin)

    within ".user-#{user.id}" do
      click_on 'Edit'
    end

    fill_in 'Email', with: 'new@test.com'
    fill_in 'Name', with: 'Bill'
    fill_in 'Birth date', with: '2017-11-03'
    fill_in 'Bio', with: 'string'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Create'

    within '.user' do
      expect(page).to have_content 'new@test.com'
      expect(page).to have_content 'Bill'
      expect(page).to have_content '2017-11-03'
      expect(page).to have_content 'string'
    end
  end
end
