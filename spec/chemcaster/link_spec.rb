require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Chemcaster::Link do
  before(:each) do
    @atts = {}
  end
  
  def do_new
    @link = Link.new @atts
  end
  
  describe "with valid attributes" do
    before(:each) do
      @atts[:name] = 'foo'
      @atts[:url] = 'http://example.com'
      @atts[:media_type] = "text/plain"
      do_new
    end
  end
end
