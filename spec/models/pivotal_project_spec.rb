require 'rails_helper'

RSpec.describe PivotalProject, type: :model do

  it "is valid when pivotal_id exists" do
    expect(PivotalProject.new(pivotal_id: 123)).to be_valid
  end
  
  it "is not valid without a pivotal_id" do
    expect(PivotalProject.new(pivotal_id: nil)).to_not be_valid
  end
end
