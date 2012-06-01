require 'helper'

class TestScribeApi < Test::Unit::TestCase
  context "scribe_api" do
    setup do
      @key = api_key
      @scribe = ScribeAPI.new( @key )
    end
    
    should "have keyword suggestions" do
      VCR.insert_cassette("kw_suggestions", :record => :new_episodes)

      params = { :keyword => "horse" }
      suggestions = @scribe.keyword_suggestions( params )

      assert_equal 10, suggestions["suggestions"].length
      assert_equal "horse", suggestions["suggestions"][0]["term"]
    end
    
    should "have keyword details" do
      VCR.insert_cassette("kw_details", :record => :new_episodes)
      
      params = { :keyword => "design", :domain => "http://blog.iso50.com" }
      details = @scribe.keyword_details( params )
      
      assert_equal 15, details.keys.length
      assert_equal 0, details["scoreDomainAuthority"]
    end
    
    should "have content analysis" do
      VCR.insert_cassette("content_analysis", :record => :new_episodes)

      params = { :title => "Stocks Claw Back" }
      params[:description] = "Stocks reversed losses and inched higher, after elections in France and Greece fueled concerns about the region's ability to deal with its sovereign-debt problems."
      params[:keyword] = "stocks"
      params[:headline] = "Stocks Claw Back"
      params[:domain] = "http://online.wsj.com"
      params[:body] = "Stocks reversed losses and inched higher, after elections in France and Greece fueled concerns about the region's ability to deal with its sovereign-debt problems. Stocks opened lower but recovered most losses by Monday afternoon. The Dow Jones Industrial Average rose 10 points, or 0.1%, to 13048. The Dow industrials fell as much as 68 points early in the session. The Standard & Poor's 500-stock index rose four points, or 0.3%, to 1373, and the Nasdaq Composite rose 13 points, 0.4%, to 2969. Vincent Cignarella and Michael Casey join Markets Hub with the U.S. reaction to weekend elections in France and Greece, and what the new order will mean for the continent's debt struggles. Financial-sector stocks rose the most, with Bank of America CVX -0.31% leading Dow components. Utility stocks trailed behind. Walt Disney DIS +1.93% rose after its latest superhero action film, 'The Avengers,' raked in over $200 million in its weekend box-office debut. Strong ticket sales validated Disney's $4 billion acquisition of Marvel Entertainment and softened the blow of the recently disappointing 'John Carter.' American International Group AIG -3.37% slumped after the U.S. government agreed to sell $5 billion of the insurer's stock at $30.50 a share, representing a 7.1% discount to Friday's closing price. Weekend elections across the Atlantic initially jostled markets."
      analysis = @scribe.content_analysis( params )
      
      assert_equal 59, analysis["docScore"]
      assert_equal ["BodyLen", "Hyper"], analysis["docScoreE"]
      assert_equal "very difficult", analysis["fleschScore"]
      assert_equal 5, analysis["keywords"].length
      assert_equal 89, analysis["scribeScore"]
      assert_equal 12, analysis["tags"].length
    end
    
    # Link Building doesn't yet work on the scribe api, so this
    # should "have link building" do
    #   VCR.insert_cassette("link_building", :record => :new_episodes)
    #   
    #   @scribe = ScribeAPI.new( @key )
    #   params = { :keyword => "llama", :domain => "simcity.com" }
    #   link_building = @scribe.link_building( params )
    #   
    #   debugger
    # end
    
    should "have user info" do
      VCR.insert_cassette("user_info", :record => :new_episodes)
      
      info = @scribe.user_information
      
      assert_equal 3, info.keys.length
      assert_equal 1, info["accountStatus"]
    end
    
    teardown do
      VCR.eject_cassette
    end
  end
end
