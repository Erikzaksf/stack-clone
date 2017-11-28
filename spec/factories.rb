FactoryBot.define do
  factory(:user) do
    user_name("Bob")
    email("bob@bob.com")
    password("bob123")
    password_confirmation("bob123")
  end

  factory(:question) do
    user
    title("Test Question")
    content("This is a test question for the testing of questions.")
  end

  factory(:vote) do
    question
    association :user, factory: :user, user_name: "Test", email: "test@test.com"
    is_upvote(true)
  end

  factory(:answer) do
    question
    association :user, factory: :user, user_name: "Test", email: "test@test.com"
    content("Example answer to a question.")
  end
end
