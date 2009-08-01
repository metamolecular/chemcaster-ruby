$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'chemcaster'
include Chemcaster

def mock_link_hash
  {
    'name' => 'create Foo',
    'uri' => 'http://foo.com',
    'media_type' => 'text/foo'
  }
end