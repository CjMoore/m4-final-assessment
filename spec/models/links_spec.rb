require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'relationships' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:url)}
    it { should validate_uniqueness_of(:title)}
  end

  it "should be valid with valid url" do
    link = Link.new(url: 'https://www.google.com/',
                    title: 'google')

    expect(link).to be_valid
  end

  it "should be invalid with invalid url" do
    link = Link.new(url: 'www.google.com',
                    title: 'google')

    expect(link).to_not be_valid
  end
end
