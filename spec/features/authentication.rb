require 'rails_helper'

feature 'Authentication' do
  let(:email) { 'new_user@resurgens.io' }
  let(:password) { 'password' }

  scenario "sign in with correct credentials" do
    create(:user, email: email, password: password, password_confirmation: password)
    pending
    visit(new_user_session_path)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log In'
    expect(page).to have_content('Signed-in successfully.')
  end
end
