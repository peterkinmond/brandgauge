require 'spec_helper'

describe CampaignsController do
  describe "get#index" do
    before do
      brand = Brand.create(:name => 'Test brand')
      user = User.create(:email => 'test@test.com', :password => 'secret', :brand => brand)
      sign_in :user, user
    end

    #it "should return all associated campaigns" do
      #get :index, :brand_id => 1
      #response.campaigns.should == []
    #end
  end
end
