require 'rails_helper'

describe "when user is on link index and they click the edit button", js: true do
  it "they are taken to an edit link form where they are able to edit links with valid inputs" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content("http://google.com")
      click_on("Edit")
    end

    expect(current_path).to eq(edit_link_path(link1))

    fill_in 'Url', with: 'http://reddit.com'
    fill_in 'Title', with: 'Reddit'

    click_on("Update Link")

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Link has been updated")
  end

  it "they cannot update a link with invalid inputs" do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(title: 'Google', url: 'http://google.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within('#link-list') do
      expect(page).to have_content("Google")
      expect(page).to have_content("http://google.com")
      click_on("Edit")
    end

    expect(current_path).to eq(edit_link_path(link1))

    fill_in 'Url', with: 'reddit.com'
    fill_in 'Title', with: 'Reddit'

    click_on("Update Link")

    expect(page).to have_content("Url is not a valid URL")
  end
end
