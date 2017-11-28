require "rails_helper"

describe Question do
  it { should belong_to :user }
  it { should have_many :votes }
  it { should have_many :answers }
  it { should validate_presence_of :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }

  describe ".recent" do
    it "returns questions in ordear of creation date" do
      question_one = FactoryBot.create(:question)
      question_two = FactoryBot.create(:question, user: question_one.user)
      question_three = FactoryBot.create(:question, user: question_one.user)
      expect(Question.all).to eq ([question_one, question_two, question_three])
    end
  end
  describe ".today_total" do
    it "returns number of questions created today" do
      question_one = FactoryBot.create(:question)
      question_two = FactoryBot.create(:question, user: question_one.user)
      question_three = FactoryBot.create(:question, user: question_one.user)
      expect(Question.today_total).to eq (3)
    end
  end

end
