require 'rails_helper'

describe "when logged in user visits root", js: true do
  it "they see a list of their links" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com')
    link2 = user.links.create(title: 'Reddit', url: 'http://reddit.com')
    link3 = Link.create(title: 'Wut', url: 'http://wut.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content('Read: false')
      expect(page).to have_content("Reddit")
      expect(page).to have_link('http://google.com')
      expect(page).to have_link('http://reddit.com')
      expect(page).to_not have_content('Wut')
      expect(page).to_not have_link('http://wut.com')
    end
  end
end
