require 'rails_helper'

RSpec.describe User, type: :model do
  let(:username) { 'testuser' }
  let(:email) { 'test@test.com' }
  let(:password) { 'password' }
  let(:user) { create(:user, email: email, password: password, password_confirmation: password, username: username) }

  # Shoulda test for associations
  it { is_expected.to have_many(:applications) }

  # Shoulda test for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to_not allow_value('dc.com').for(:email) }
  it { is_expected.to allow_value('dave@doc.com').for(:email) }

  # Shoulda test for username
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_least(3) }
  it { is_expected.to validate_length_of(:username).is_at_most(30) }

  # Shoulda test for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6)}

  describe "attributes" do
    it "has email, username and password attributes" do
      expect(user).to have_attributes(email: email, password: password, username: username)
    end
  end
end
