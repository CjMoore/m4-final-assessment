require 'rails_helper'

describe "when guest user visits root they are redirected to signup page" do
  it "They click on the link to sign in and give correct credentials and are signed in" do
    user = User.create(email: 'email@email.com', password: 'pass')

    visit root_path

    expect(current_path).to eq(signup_path)

    click_on("Login")

    expect(current_path).to eq(login_path)

    fill_in "Email", with: 'email@email.com'
    fill_in 'Password', with: 'pass'

    click_on("Login")

    expect(current_path).to eq(root_path)
    expect(page).to have_content('email@email.com has successfully logged in')
  end

  it "they cannot login with invalid credentials" do
    user = User.create(email: 'email@email.com', password: 'pass')

    visit root_path

    expect(current_path).to eq(signup_path)

    click_on("Login")

    expect(current_path).to eq(login_path)

    fill_in "Email", with: 'email@email.com'
    fill_in 'Password', with: 'password'

    click_on("Login")

    expect(page).to have_content("User Email or Password invalid")
  end
end
