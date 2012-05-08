require 'httparty'

class ScribeAPI
  include HTTParty
  headers 'Content-Type' => 'application/json' 
  
  # un-comment the next line to enable debug output from httparty
  debug_output $stdout
  
  base_uri "api.scribeseo.com"
  
  def initialize( key )
    @key = key
  end
  
  def keyword_suggestions( params )
    options = { :body => { :query => params[:keyword] } }
    self.class.post( "/analysis/kw/suggestions?apikey=#{@key}", options )
  end
  
  def keyword_details( params )
    options = { :body => { :query => params[:keyword], :domain => params[:domain] } }
    self.class.post( "/analysis/kw/detail?apikey=#{@key}", options )
  end
  
  def content_analysis( params )
    options = { :body => { :htmlTitle => params[:title], :htmlDescription => params[:description], :htmlHeadline => params[:headline], :htmlBody => params[:body], :targetedKeyword => params[:keyword], :domain => params[:domain] } }
    self.class.post( "/analysis/content?apikey=#{@key}", options )
  end
  
  def link_building( params )
    options = { :body => { :query => params[:keyword], :domain => params[:domain] }, :headers => { 'Content-Type' => 'application/json' } }
    # this is disabled cause scribe is working on this endpt.
    # self.class.post( "/analysis/link?apikey=#{@key}", options )
  end
  
  def user_information( )
    self.class.get( "/membership/user/detail?apikey=#{@key}" )
  end
end