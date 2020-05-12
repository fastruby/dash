# require 'rails_helper'
#
# RSpec.describe OctokitService, type: :service do
#   before do
#     allow(subject).to receive(:current_user).and_return(user)
#     allow(subject).to receive(:access_token).and_return(ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
#   end
#
#   describe "initialize" , :vcr do
#     context "when client is created" do
#       it "returns client data" do
#         expect(@client).to be
#       end
#     end
#
#   describe "get_issues"
#     context "when get_issues finds issues" do
#       it "returns an array of issues" do
#         expect(project.valid?).to be_falsey
#         expect(project.errors.full_messages).to eq(["Name can't be blank"])
#       end
#     end
#   end
#
#     context "when get_issues has no issues" do
#       it "returns nothing" do
#         project = Project.new
#         expect(project.valid?).to be_falsey
#         expect(project.errors.full_messages).to eq(["Name can't be blank"])
#       end
#     end
#   end
# end
