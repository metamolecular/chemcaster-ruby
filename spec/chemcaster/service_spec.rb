require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Service do
  before(:each) do
    @test_class = Service
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
  
  describe "with all attributes" do
    before(:each) do
      @attributes = {
        'version' => '1.0.0'
      }
    end
    
    it_should_behave_like "representation with all attributes"
  end
  
  describe "with all links" do
    before(:each) do
      @resources = {
        'registries' => mock(Index)
      }
    end
      
    it_should_behave_like "representation with all resources"
  end
end