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

  it "displays an error message if question cannot be saved" do
    user = FactoryBot.create(:user)
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit new_question_path
    click_on "Create Question"
    expect(page).to have_content("Something went wrong!")
  end

  it "allows a user to edit their questions" do
    question = FactoryBot.create(:question)
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_on "Edit"
    fill_in "Title", with: "different"
    click_on "Update Question"
    expect(page).to have_content("different")
  end

  it "display error if update was unsuccessful" do
    question = FactoryBot.create(:question)
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_on "Edit"
    fill_in "Title", with: ""
    click_on "Update Question"
    expect(page).to have_content("Something went wrong!")
  end

  it "does not allow unauthorized users to edit questions" do
    question = FactoryBot.create(:question)
    user = FactoryBot.create(:user, user_name: "bob2", email: "bob2@bob.com")
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit edit_question_path(question)
    expect(page).to have_content("You aren't authorized to access that.")
  end

  it "does not allow unauthorized users to send updates" do
    question = FactoryBot.create(:question)
    user = FactoryBot.create(:user, user_name: "bob2", email: "bob2@bob.com")
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    Capybara.current_session.driver.submit :patch, question_path(question), nil
    expect(page).to have_content("You aren't authorized to do that.")
  end

  it "allows user to delete their questions" do
    question = FactoryBot.create(:question, title: "Question to delete")
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_on "Delete"
    expect(page).to have_content("Question deleted successfully!")
    expect(page).to have_no_content("Question to delete")
  end

  it "does not allow unauthorized users to delete questions" do
    question = FactoryBot.create(:question)
    user = FactoryBot.create(:user, user_name: "bob2", email: "bob2@bob.com")
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    Capybara.current_session.driver.submit :delete, question_path(question), nil
    expect(page).to have_content("You aren't authorized to do that.")
  end
end
