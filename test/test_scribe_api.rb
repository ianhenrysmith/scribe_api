require 'helper'
require 'open-uri'

class TestScribeApi < Test::Unit::TestCase
  context "scribe_api" do
    setup do
      @key = "scribe-2c81aaba77ca4fc4bcf0a94812dd5e32"
    end
    
    # should "have keyword suggestions" do
    #   @scribe = ScribeAPI.new( @key )
    #   params = { :keyword => "horse" }
    #   suggestions = @scribe.keyword_suggestions( params )
    #   puts suggestions
    # end
    # 
    # should "have keyword details" do
    #   @scribe = ScribeAPI.new( @key )
    #   params = { :keyword => "design", :domain => "http://blog.iso50.com" }
    #   details = @scribe.keyword_details( params )
    #   puts details
    # end
    # 
    should "have content analysis" do
      @scribe = ScribeAPI.new( @key )
      params = { :title => "<title>Stocks Claw Back</title>" }
      params[:description] = "<meta property='og:description' content='Stocks reversed losses and inched higher, after elections in France and Greece fueled concerns about the region's ability to deal with its sovereign-debt problems.' >"
      params[:keyword] = "stocks"
      params[:headline] = "<h1>Stocks Claw Back</h1>"
      params[:domain] = "http://online.wsj.com"
      params[:body] = "<p>Stocks reversed losses and inched higher, after elections in France and Greece fueled concerns about the region's ability to deal with its sovereign-debt problems. Stocks opened lower but recovered most losses by Monday afternoon. The Dow Jones Industrial Average rose 10 points, or 0.1%, to 13048. The Dow industrials fell as much as 68 points early in the session. The Standard & Poor's 500-stock index rose four points, or 0.3%, to 1373, and the Nasdaq Composite rose 13 points, 0.4%, to 2969. Vincent Cignarella and Michael Casey join Markets Hub with the U.S. reaction to weekend elections in France and Greece, and what the new order will mean for the continent's debt struggles. Financial-sector stocks rose the most, with Bank of America CVX -0.31% leading Dow components. Utility stocks trailed behind. Walt Disney DIS +1.93% rose after its latest superhero action film, 'The Avengers,' raked in over $200 million in its weekend box-office debut. Strong ticket sales validated Disney's $4 billion acquisition of Marvel Entertainment and softened the blow of the recently disappointing 'John Carter.' American International Group AIG -3.37% slumped after the U.S. government agreed to sell $5 billion of the insurer's stock at $30.50 a share, representing a 7.1% discount to Friday's closing price. Weekend elections across the Atlantic initially jostled markets.</p>"
      analysis = @scribe.content_analysis( params )
      puts analysis
    end
    
    # should "have link building" do
    #   @scribe = ScribeAPI.new( @key )
    #   params = { :keyword => "llama", :domain => "simcity.com" }
    #   link_building = @scribe.link_building( params )
    #   puts link_building
    # end
    
    # should "have user info" do
    #   @scribe = ScribeAPI.new( @key )
    #   info = @scribe.user_information
    #   puts info
    # end
  end
end
