require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'test@test.com' }
  let(:password) { 'password' }
  let(:user) { create(:user, email: email, password: password, password_confirmation: password) }

  # Shoulda test for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to_not allow_value('dc.com').for(:email) }
  it { is_expected.to allow_value('dave@doc.com').for(:email) }

  # Shoulda test for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6)}

  describe "attributes" do
    it "has email and password attributes" do
      expect(user).to have_attributes(email: email, password: password)
    end
  end
end
