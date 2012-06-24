require 'spec_helper'

describe StagesController do

  describe "GET 'show'" do
    it "assigns a stage" do
      stage = FactoryGirl.create(:stage)
      get :show, { id: stage.id }
      assigns(:stage).should eq(stage)
    end
  end

end
