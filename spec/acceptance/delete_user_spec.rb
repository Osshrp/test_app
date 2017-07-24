require 'rails_helper'

feature 'Admin deletes user', %q{
  Admin can delete user
} do

  given!(:user) { create(:user, email: 'deleted@test.com') }
  given(:admin) { create(:user, admin: true) }

  scenario 'Admin tries to delete user' do
    sign_in(admin)
    expect(page).to have_content 'deleted@test.com'

    within ".user-#{user.id}" do
      click_on 'Delete'
    end
    expect(page).to_not have_content 'deleted@test.com'
  end

  scenario 'User tries to delete user' do
    sign_in(user)
    visit admin_users_path

    expect(page).to have_content 'You have no rights to access to that page'
  end
end
