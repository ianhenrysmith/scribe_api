require 'pathname'
require 'rubygems'
require 'bundler'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'
require 'ruby-debug'

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
  def fixture_file( path )
    Pathname(__FILE__).dirname.join(*path.split('/')).read
  end
end
