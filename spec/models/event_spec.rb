require 'rails_helper'

RSpec.describe Event, type: :model do

  # Shoulda tests for associations
  it { is_expected.to belong_to(:registered_application) }
end
