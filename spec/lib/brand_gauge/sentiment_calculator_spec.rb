require 'spec_helper'

describe BrandGauge::SentimentCalculator do
  describe "#initialize" do
    it "should load the AFINN word list from 'public/AFINN'" do
      subject.word_list.should be
    end
  end

  describe "#analzye" do
    it "returns positive sentiment for a positive sentence" do
      subject.analyze("wow that was amazing").should == 8
    end

    it "returns negative value for negative sentence" do
      subject.analyze("I fucking hate you").should == -7
    end
  end
  
end
