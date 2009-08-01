require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Service do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @service = Service.new @hash
  end
  
  describe "with registries" do
    before(:each) do
      @link_hash = mock_link_hash
      @hash['registries'] = @link_hash
      @registries = mock(Link)
      Link.stub!(:new).with(@link_hash).and_return(@registries)
      do_new
    end
    
    it "returns registries" do
      @service.registries.should == @registries
    end
  end
end