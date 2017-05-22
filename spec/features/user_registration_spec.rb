require 'rails_helper'

describe "when a guest user visits root they are redirected to sign up or login" do
  it "when they click the sign up link they are taken to a form" do
    visit root_path

    expect(current_path).to eq(signup_path)

    click_on("Register")

    expect(current_path).to eq(new_user_path)

    fill_in "Email", with: 'email@email.com'
    fill_in "Password", with: 'pass'
    fill_in 'Password confirmation', with: 'pass'

    click_on('Create Account')

    expect(current_path).to eq(root_path)
    expect(page).to have_content('email@email.com has successfully logged in')
  end
end