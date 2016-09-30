$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'piano'
require 'test/unit'
require 'rack/test'

class HomeTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Piano::App
  end

  def test_root
    get '/'
    assert last_response.ok?
  end
end
