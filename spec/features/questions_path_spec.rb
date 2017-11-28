require "rails_helper"

describe "the question management path" do
  it "allows a user to add a new question" do
    user = FactoryBot.create(:user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit questions_path
    click_on "Ask a Question"
    fill_in "Title", with: "This is a test."
    fill_in "Content", with: "This is also a test."
    click_on "Create Question"
    expect(page).to have_content("This is a test.")
  end
end
