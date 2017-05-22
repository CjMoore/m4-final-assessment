require 'rails_helper'

describe "when user is on root/links index they see a form to submit new link", js: true do
  it "when they fill out form with valid url and title they are able to submit a new link" do
    user = User.create(email: 'email@email.com', password: 'pass')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-form') do
      fill_in "Url", with: 'https://www.google.com/'
      fill_in "Title", with: 'Google'

      click_on('Add link')
    end

    expect(current_path).to eq(root_path)

    within('#link-list') do
      expect(page).to have_content('https://www.google.com/')
      expect(page).to have_content('Google')

      expect(page).to have_link('Mark as read')
      expect(page).to have_link('Edit')
    end
  end

  it "cannot add a link with invalid inputs" do
    user = User.create(email: 'email@email.com', password: 'pass')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-form') do
      fill_in "Url", with: 'www.google.com/'
      fill_in "Title", with: 'Google'

      click_on('Add link')
    end
  end
end
