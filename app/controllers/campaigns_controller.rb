class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @campaigns = Campaign.where(:brand_id => current_user.brand)
  end

  def show
    if params[:brand_id].to_i != current_user.brand.id
      raise ActionController::RoutingError.new('Not Found')
    end
    @campaign = Campaign.find(params[:id])
  end

  def create
    brand = Brand.find(params[:brand_id])
    campaign = Campaign.new(params[:campaign])
    campaign.brand = brand
    campaign.save
    @campaigns = Campaign.where(:brand_id => current_user.brand)
    render :index
  end
end
