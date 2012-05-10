require 'httparty'
require 'json'

class ScribeAPI
  include HTTParty
  headers 'Content-Type' => 'application/json' 
  default_params :output => 'json'
  format :json
  
  # un-comment the next line to enable debug output from httparty
  # debug_output $stdout
  
  base_uri "api.scribeseo.com"
  
  def initialize( key )
    @key = key
  end
  
  def keyword_suggestions( params={} )
    options = { :body => { :query => params[:keyword] }.to_json }
    httparty = self.class.post( "/analysis/kw/suggestions?apikey=#{@key}", options )
    result = {}
    
    if httparty.code == 200
      result = httparty.parsed_response
    end
    result
  end
  
  def keyword_details( params={} )
    options = { :body => { :query => params[:keyword], :domain => params[:domain] }.to_json }
    httparty = self.class.post( "/analysis/kw/detail?apikey=#{@key}", options )
    result = {}
    
    if httparty.code == 200
      result = httparty.parsed_response
    end
    result
  end
  
  def content_analysis( params={} )
    options = { :body => { :htmlTitle => params[:title], :htmlDescription => params[:description], :htmlHeadline => params[:headline], :htmlBody => params[:body], :targetedKeyword => params[:keyword], :domain => params[:domain] }.to_json }
    httparty = self.class.post( "/analysis/content?apikey=#{@key}", options )
    result = {}
    
    if httparty.code == 200
      result = httparty.parsed_response
    end
    result
  end
  
  def link_building( params={} )
    # options = { :body => { :query => params[:keyword], :domain => params[:domain] }.to_json }
    # httparty =self.class.post( "/analysis/link?apikey=#{@key}", options )
    # 
    # if httparty.code == 200
    #   result = httparty.parsed_response
    # end
    # result
    
    # return empty hash cause scribe is working on this endpt.
    {}
  end
  
  def user_information( params={} )
    httparty = self.class.get( "/membership/user/detail?apikey=#{@key}" )
    result = {}
    
    if httparty.code == 200
      result = httparty.parsed_response
    end
    result
  end
end