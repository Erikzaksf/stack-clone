require "rails_helper"

describe "the answer management path" do
  it "allows a user to create an answer for a question" do
    question = FactoryBot.create(:question)
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    fill_in "answer_content", with: "This is an example answer."
    click_on "Create Answer"
    expect(page).to have_content("This is an example answer.")
    expect(page).to have_content("Answer saved successfully")
  end

  it "displays an error message if something went wrong while saving" do
    question = FactoryBot.create(:question)
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_on "Create Answer"
    expect(page).to have_content("Something went wrong")
  end

  it "allows user to edit their answers" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = answer.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_link "Edit"
    fill_in "Content", with: "This is a new answer."
    click_on "Update Answer"
    expect(page).to have_content("This is a new answer.")
    expect(page).to have_content("Answer updated successfully")
  end

  it "doesn't allow user to edit other user's answers" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit edit_question_answer_path(question, answer)
    expect(page).to have_content("You aren't authorized to do that.")
  end

  it "displays an error if edit cannot be saved" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = answer.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit edit_question_answer_path(question, answer)
    fill_in "Content", with: ""
    click_on "Update Answer"
    expect(page).to have_content("Something went wrong")
  end

  it "does not allow a user to send an update for another user's answer" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    Capybara.current_session.driver.submit :patch, question_answer_path(question, answer), nil
    expect(page).to have_content("You aren't authorized to do that.")
  end

  it "allows a user to delete their own answers" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = answer.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit question_path(question)
    click_on "Delete"
    expect(page).to have_content("Answer deleted successfully!")
    expect(page).to have_no_content("Example answer to a question")
  end

  it "does not allow the user to delete other user's answers" do
    answer = FactoryBot.create(:answer)
    question = answer.question
    user = question.user
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    Capybara.current_session.driver.submit :delete, question_answer_path(question, answer), nil
    expect(page).to have_content("You aren't authorized to do that.")
  end
end
