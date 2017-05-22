require 'rails_helper'

describe "user can change read status of link", js: true do
  it "to read" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      click_on("Mark as read")
      expect(page).to have_content("Read: true")
    end

  end

  it "to unread" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com', read: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Read: true")
      click_on("Mark as unread")
      expect(page).to have_content("Read: false")
    end
  end
end
