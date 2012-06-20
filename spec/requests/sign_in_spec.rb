require 'spec_helper'

describe "SignIn" do
  describe "GET /sign_in" do
    it "works" do
      visit new_user_session_path
      page.should have_selector("h2", text: "Sign in")
    end
  end
end
