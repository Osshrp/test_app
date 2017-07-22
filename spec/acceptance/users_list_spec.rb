require 'rails_helper'

feature 'Users list', %q{
  In order to find the required user,
  I should have the opportunity
  to view the list of users
} do
  given!(:users) { create_list(:user, 2) }

  scenario 'Authenticated user views list of questions' do
    sign_in(users.first)
    visit users_path

    expect(page).to have_content users.first.email
    expect(page).to have_content users.last.email
  end

  scenario 'Unauthenticated user views list of question' do
    visit users_path

    expect(page).to have_content users.first.email
    expect(page).to have_content users.last.email
  end
end
