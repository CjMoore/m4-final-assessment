require 'rails_helper'

describe "when a user clicks on read", js: true do
  it "if that link is a hot read the card says hot" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link = user.links.create(url: 'http://bb.com', title: 'bb')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      click_on("Mark as read")
      expect(page).to have_content("Read: true")
      expect(page).to have_content('Hot!')
    end
  end
end
