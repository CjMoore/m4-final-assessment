require 'rails_helper'

RSpec.describe User, type: :model do
  context "relationships" do
    it {should have_many(:links)}
  end
  
  context "secure password" do
    it { should have_secure_password }
  end

  context "validations" do
    it { is_expected.to validate_uniqueness_of(:email) }
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:email)}
  end
end
