require 'spec_helper'

describe "Companies" do
  describe "GET /companies" do
    it "redirects to sign in page if user isn't logged in" do
      get companies_path
      response.should redirect_to new_user_session_path
    end
  end
end
