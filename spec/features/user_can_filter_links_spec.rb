require 'rails_helper'

describe "user can filter links", js: true do
  it "by using the input field above links" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com')
    link2 = user.links.create(title: 'Reddit', url: 'http://reddit.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content("Reddit")
    end

    fill_in 'Filter', with: 'g'

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to_not have_content('Reddit')
    end
  end

  it "by clicking show read button" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com', read: true)
    link2 = user.links.create(title: 'Reddit', url: 'http://reddit.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content("Reddit")
    end

    click_on("Show Read")

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to_not have_content("Reddit")
    end
  end

  it "by clickin show unread button" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com', read: true)
    link2 = user.links.create(title: 'Reddit', url: 'http://reddit.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content("Reddit")
    end

    click_on("Show Unread")

    within('#link-list') do
      expect(page).to have_content("Reddit")
      expect(page).to_not have_content("Google")
    end
  end
end
