require 'rails_helper'

RSpec.describe 'Sign in with github' do
  before do
    OmniAuth.config.logger = Rails.logger
    visit root_path
  end

  it "has a sign in link" do
    expect(page).to have_content("Sign in")
  end

  context "when sign in with github succeeds" do
    before do
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:github] = {
        "provider" => "github",
        "uid" => "64282342",
        "credentials" => {
          "token" => "ASJDKLFJADSLKJADSKLJDSLFJ"
        },
        "info" => {
          "name" => "Ombu Bot"
        }
      }
    end

    it "signs me in" do
      click_on "Sign in"
      expect(page).to have_content("Signed in!")
    end
  end

  context "when sign in with github fails" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
    end

    it "does not sign me in and shows an error message" do
      click_on "Sign in"
      expect(page).to_not have_content("Signed in!")
      expect(page).to have_content("We couldn't sign you in! (Error: invalid_credentials)")
    end
  end
end
