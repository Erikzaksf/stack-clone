require 'rails_helper'

describe Answer do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }

  describe ".today_total" do
    it "returns number of questions created today" do
      answer_one = FactoryBot.create(:answer)
      answer_two = FactoryBot.create(:answer, user: answer_one.user, question: answer_one.question)
      answer_three = FactoryBot.create(:answer, user: answer_one.user, question: answer_one.question)
      expect(Answer.today_total).to eq (3)
    end
  end


end
