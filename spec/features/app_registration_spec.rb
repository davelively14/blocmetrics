require 'rails_helper'

RSpec.feature 'AppRegistration', type: :feature do
  let(:username) { 'new_user' }
  let(:email) { 'new_user@resurgens.io' }
  let(:password) { 'password' }
  let(:name) { Faker::StarWars.character }
  let(:url) { Faker::Internet.url }

  before do
    create(:user, email: email, password: password, password_confirmation: password, username: username)
  end

  scenario "register new app" do
    sign_in_user(email, password)
    click_on 'My Apps'
    click_on 'Register New App'
    expect(current_path).to eq(new_registered_application_path)
    fill_in 'Name', with: ''
    fill_in 'Url', with: ''
    click_button 'Save'
    expect(page).to have_content("Name is too short")
    fill_in 'Name', with: name
    click_button 'Save'
    expect(page).to have_content("Url is too short")
    fill_in 'Url', with: url
    click_button 'Save'
    expect(page).to have_content(name)
    expect(current_path).to eq(registered_application_path(RegisteredApplication.last))
  end

  scenario "navigate to show from the index" do
    sign_in_user(email, password)
    create_app(name, url)
    expect(page).to have_content(name)
    click_link 'My Apps'
    click_link name
    expect(page).to have_content(name)
    expect(page).to have_content(url)
    expect(current_path).to eq(registered_application_path(RegisteredApplication.last))
  end

  scenario "unregister an app from the index view" do
    sign_in_user(email, password)
    create_app(name, url)
    click_on 'My Apps'
    expect(page).to have_content('Apps: 1')
    click_link 'Unregister'
    expect(page).to have_content("#{name} was unregistered successfully.")
    expect(page).to have_content('Apps: 0')
  end

  scenario "unregister an app from the show view" do
    sign_in_user(email, password)
    create_app(name, url)
    click_on 'My Apps'
    click_link name
    click_link 'Unregister'
    expect(page).to have_content("#{name} was unregistered successfully.")
    expect(page).to have_content('Apps: 0')
    expect(current_path).to eq(registered_applications_path)
  end

  scenario "edit and update an app from index view" do
    sign_in_user(email, password)
    create_app(name, url)
    click_on 'My Apps'
    click_link 'Edit'
    fill_in 'Name', with: ''
    click_button 'Save'
    expect(page).to have_content('Name is too short')
    fill_in 'Name', with: 'New Name'
    click_button 'Save'
    expect(current_path).to eq(registered_application_path(RegisteredApplication.last))
    expect(page).to have_content('New Name')
    expect(page).to_not have_content(name)
  end

  scenario "edit and update an app from show view" do
    sign_in_user(email, password)
    create_app(name, url)
    click_on 'My Apps'
    click_link name
    click_link 'Edit'
    fill_in 'Name', with: ''
    click_button 'Save'
    expect(page).to have_content('Name is too short')
    fill_in 'Name', with: 'New Name'
    click_button 'Save'
    expect(current_path).to eq(registered_application_path(RegisteredApplication.last))
    expect(page).to have_content('New Name')
    expect(page).to_not have_content(name)
  end

  private

  def sign_in_user(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
  end

  def create_app(name, url)
    visit new_registered_application_path
    fill_in 'Name', with: name
    fill_in 'Url', with: url
    click_button 'Save'
  end
end
