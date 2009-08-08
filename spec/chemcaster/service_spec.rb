require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Service do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @service = Service.new mock(Link), @hash
  end
  
  describe "with registries" do
    before(:each) do
      @link_hash = mock_link_hash
      @hash['registries'] = @link_hash
      @registries = mock(Index)
      @registries_link = mock(Link, :get => @registries)
      Link.stub!(:new).and_return(@registries_link)
      do_new
    end
    
    it "returns registries link" do
      @service.registries_link.should == @registries_link
    end
    
    it "returns registries" do
      @service.registries.should == @registries
    end
  end
end