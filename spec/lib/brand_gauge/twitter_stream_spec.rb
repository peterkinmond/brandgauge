require 'spec_helper'

describe BrandGauge::TwitterStream do

  describe "#keywords_to_track" do
    let(:fake_campaigns) { double('fake campaigns') }
    it "should get all campaign keywords and brand names" do
      Brand.should_receive(:all_brand_names).and_return(["fake Brand"])
      Campaign.should_receive(:all_hashtags).and_return(["#fake"])
      subject.keywords_to_track.should == ["fake brand", "#fake"]
    end
  end

  describe "#consume" do
    let(:fake_stream) { double(TweetStream::Client) }
    let(:fake_keywords) { ["fake phrase", "fake brand name"] }
    let(:fake_tweet_handler) { double(BrandGauge::TweetHandler, :process => nil) }

    before do
      BrandGauge::TweetHandler.stub(:new => fake_tweet_handler)
      TweetStream::Client.stub(:new => fake_stream)
      subject.stub(:keywords_to_track => fake_keywords )
    end

    it "should start a stream tracking all keywords" do
      fake_stream.should_receive(:track).with(*fake_keywords)
      subject.consume
    end

    it "should call process on the tweet handler for each tweet" do
      fake_stream.should_receive(:track).and_yield("fake tweet")
      fake_tweet_handler.should_receive(:process).with("fake tweet")
      subject.consume
    end 
    
  end
  
end
