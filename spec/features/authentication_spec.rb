require "rails_helper"

describe "the authentication process" do
  it "allows a user to create an account" do
    visit signup_path
    fill_in "user_user_name", with: "testuser"
    fill_in "user_email", with: "testuser@test.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    click_button "Sign Up"
    expect(page).to have_content("You've successfully signed up!")
    expect(page).to have_content("testuser")
  end

  it "returns an error message if there is a problem signing up" do
    visit signup_path
    click_button "Sign Up"
    expect(page).to have_content("There was a problem signing up.")
  end

  it "signs a user out when they click sign out" do
    user = FactoryBot.create(:user)
    visit signin_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Sign in"
    click_link "Sign out"
    expect(page).to have_no_content(user.user_name)
    expect(page).to have_content("You've signed out.")
  end

  it "does not allow user to sign in with incorrect password" do
    user = FactoryBot.create(:user)
    visit signin_path
    fill_in "email", with: user.email
    fill_in "password", with: "not the password"
    click_button "Sign in"
    expect(page).to have_content("There was a problem signing in.")
  end
end
