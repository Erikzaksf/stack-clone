require 'rails_helper'

describe Answer do
  it { should belong_to :question }
  it { should belong_to :user }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }
end
