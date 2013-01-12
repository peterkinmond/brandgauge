module BrandGauge
  class SentimentCalculator
    attr_reader :word_list
    def initialize
      load_word_list
    end

    def analyze(text)
      words = text.split
      words.inject(0) do |sum, word|
        sum + @word_list[word].to_i
      end
    end

    def load_word_list
      @word_list = {}
      word_file = File.open(File.expand_path(File.join(File.dirname(__FILE__), "../..", "public", "AFINN", "AFINN-111.txt")))
      word_file.each do |line|
        word_value_pair = line.split(/\s/)
        @word_list[word_value_pair[0]] = word_value_pair[1]
      end
    end
    private :load_word_list
  end
end
