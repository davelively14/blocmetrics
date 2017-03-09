require 'rails_helper'

RSpec.describe Application, type: :model do

  # Shoulda tests for associations
  it { is_expected.to belong_to(:user) }
end
