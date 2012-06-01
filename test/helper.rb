require 'pathname'
require 'rubygems'
require 'bundler'
require 'test/unit'
require 'shoulda'
require 'ruby-debug'
require 'json'
require "vcr"
# FakeWeb.allow_net_connect = false

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'scribe_api'

class Test::Unit::TestCase
  VCR.configure do |c|
    VCR.turn_on!
    c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
    c.hook_into :webmock
    WebMock.allow_net_connect!
  end
  
  def fixture_file( path )
    Pathname(__FILE__).dirname.join(*path.split('/')).read
  end
  
  def api_key
    JSON.parse(File.read("test/config.json"))["config"]["scribe_api_key"]
  end
end
