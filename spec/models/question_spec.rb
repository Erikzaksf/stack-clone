require "rails_helper"

describe Question do
  it { should belong_to :user }
  it { should have_many :votes }
  it { should validate_presence_of :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }

end
