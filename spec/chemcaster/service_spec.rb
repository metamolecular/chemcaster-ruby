require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Service do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @service = Service.new mock(Link), @hash
  end
  
  describe "connnect" do
    before(:each) do
      @username = 'foo@example.com'
      @password = 'secret'
    end
    
    def do_connect
      Service.connect(@username, @password)
    end
    
    describe "when successful" do
      before(:each) do
        @service = mock(Service)
        @link = mock(Link, :get => @service)
        Link.stub!(:new).and_return @link
      end
      
      it "returns link" do
        do_connect.should == @service
      end
    end
  end
  
  describe "with registries" do
    before(:each) do
      @link_hash = mock_link_hash
      @hash['registries'] = @link_hash
      @registries = mock(Index)
      @registries_link = mock(Link, :get => @registries)
      Link.stub!(:new).and_return(@registries_link)
      @hash['service'] = {
        'version' => 'v1.0'
      }
      do_new
    end
    
    it "returns registries link" do
      @service.registries_link.should == @registries_link
    end
    
    it "returns registries" do
      @service.registries.should == @registries
    end
    
    it "returns version" do
      @service.version.should == 'v1.0'
    end
  end
end