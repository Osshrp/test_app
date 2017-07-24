require 'rails_helper'

feature 'Admin sends pdf' do

  given!(:user) { create(:user) }
  given(:admin) { create(:user, admin: true) }

  scenario 'Admin tries to send pdf' do
    sign_in(admin)

    within ".user-#{user.id}" do
      click_on 'Send user info to email'
    end
    expect(page).to have_content 'PDF file will be create and send via email later'
  end

  scenario 'User tries to send pdf' do
    sign_in(user)
    visit admin_users_path

    expect(page).to have_content 'You have no rights to access to that page'
  end
end
