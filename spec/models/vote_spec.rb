require "rails_helper"

describe Vote do
  it { should belong_to :user }
  it { should belong_to :question }
  it { should validate_presence_of :user }

end
