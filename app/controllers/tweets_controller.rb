class TweetsController < ApplicationController
  before_filter :authenticate_user!
  def count
    count = 0
    if params[:type] == "campaign"
      @campaign = Campaign.find(params[:id])
      count = @campaign.tweet_count_in_last_n_seconds
    elsif params[:type] == "brand"
      @brand = Brand.find(params[:id])
      count = @brand.tweet_count_in_last_n_seconds
    end
    render :text => count
  end

  def index
    @campaign = Campaign.find(params[:campaign_id])
    @tweets = @campaign.tweets_in_last_n_seconds
    render 'index', :layout => false
  end
end
