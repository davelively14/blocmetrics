require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do

  # Shoulda tests for assoications
  it { is_expected.to belong_to(:user) }
end
