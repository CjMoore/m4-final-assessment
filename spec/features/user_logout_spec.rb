require 'rails_helper'

describe "when logged in user clicks logout" do
  it "their session is cleared" do
    user = User.create(email: 'email@email.com', password: 'pass')

    visit root_path

    expect(current_path).to eq(signup_path)

    click_on("Login")

    expect(current_path).to eq(login_path)

    fill_in "Email", with: 'email@email.com'
    fill_in 'Password', with: 'pass'

    click_on("Login")

    expect(current_path).to eq(root_path)

    within('.nav-wrapper') do
      click_on('Logout')
    end

    expect(current_path).to eq(signup_path)
  end
end
