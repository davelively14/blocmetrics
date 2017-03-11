require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  let(:user) { create(:user) }
  let(:name) { 'Test Name' }
  let(:url) { 'https://greenbrier.com/'}
  let(:app) { create(:registered_application, name: name, url: url, user_id: user.id) }

  # Shoulda tests for assoications
  it { is_expected.to belong_to(:user) }

  # Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }

  # Shoulda tests for url
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_length_of(:url).is_at_least(3) }

  # Shoulda tests for user_id
  it { is_expected.to validate_presence_of(:user_id) }

  describe "attributes" do
    it "has name, url, and user_id attributes" do
      expect(app).to have_attributes(name: name, url: url, user_id: user.id)
    end
  end
end
