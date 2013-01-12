require 'spec_helper'

describe BrandGauge::TweetHandler do
  describe "#process" do
    it "should store the raw tweet in the raw_tweet database" do
      RawTweet.should_receive(:create!).with({content: "fake tweet data".to_json}) 
      subject.process("fake tweet data")
    end

    it "should enqueue a resque job to enrich the tweet" do
      Resque.should_receive(:enqueue).with(BrandGauge::Jobs::EnrichTweet, 1)
      RawTweet.stub(:create! => stub(:id => 1))
      subject.process("fake tweet data")
    end

    it "should catch all exceptions and log any errors" do
      RawTweet.stub(:create!).and_raise("invalid tweet")
      lambda { subject.process("fake tweet data") }.should_not raise_error
    end
  end
end
