require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  let(:username) { 'new_user' }
  let(:email) { 'new_user@resurgens.io' }
  let(:password) { 'password' }

  before do
    create(:user, email: email, password: password, password_confirmation: password, username: username)
    clear_emails
  end

  scenario "sign in with correct credentials" do
    visit(root_path)
    click_on 'Sign in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
    expect(current_path).to eq(root_path)
  end

  scenario "cannot sign in with incorrect credentials" do
    visit(root_path)
    click_on 'Sign in'
    fill_in 'Email', with: email
    fill_in 'Password', with: "incorrect_password"
    click_button 'Sign in'
    expect(page).to have_content('Invalid Email or password.')
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "create new user" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: 'stan'
    fill_in 'Email', with: 'stan@bloc.io'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eq(root_path)
  end

  scenario "cannot create a user with an already existing email" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: 'jon316'
    fill_in 'Email', with: 'new_user@resurgens.io'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Email has already been taken')
  end

  scenario "cannot create a user with an already existing username" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: 'new_user'
    fill_in 'Email', with: 'austin316@resurgens.io'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Username has already been taken')
  end

  scenario "cannot create a user without a valid email" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: 'jon316'
    fill_in 'Email', with: 'n.com.is.alot'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Email is invalid')
  end

  scenario "cannot create a user without a valid username" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: ''
    fill_in 'Email', with: 'n@b.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content("Username can't be blank")
  end

  scenario "cannot create a user without a valid password" do
    visit(root_path)
    click_on 'Sign up'
    fill_in 'Username', with: 'billybob'
    fill_in 'Email', with: 'n@bloc.com'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    click_button 'Sign up'
    expect(page).to have_content('Password is too short')
  end

  scenario "reset password" do
    visit(root_path)
    click_on 'Sign in'
    click_on 'Forgot your password?'
    expect(current_path).to eq(new_user_password_path)
    fill_in 'Email', with: email
    click_button 'Send me reset password instructions'
    expect(current_path).to eq(new_user_session_path)
    open_email(email)
    current_email.click_link 'Change my password'
    expect(current_path).to eq(edit_user_password_path)
    fill_in 'New password', with: 'password2'
    fill_in 'Confirm new password', with: 'password2'
    click_button 'Change my password'
    expect(page).to have_content('Your password has been changed successfully. You are now signed in.')
    expect(current_path).to eq(root_path)
  end
end
