require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Chemcaster::Link do
  before(:each) do
    @atts = {}
  end
  
  def do_new
    @link = Link.new({'name' => @name, 'uri' => @uri, 'media_type' => @media_name})
  end
  
  describe "with valid attributes" do
    before(:each) do
      @name = 'foo'
      @uri = 'http://example.com'
      @media_name = 'text/plain'
      @client = mock(RestClient::Resource, :get => nil)
      @media_type = mock(MediaType, :name => @media_name, :representation => nil)
      RestClient::Resource.stub!(:new).and_return(@client)
      MediaType.stub!(:locate).and_return @media_type
    end
    
    it "creates the client" do
      RestClient::Resource.should_receive(:new).with(@uri).and_return(@client)
      do_new
    end
    
    it "locates the media type" do
      MediaType.should_receive(:locate).with(@media_name)
      do_new
    end
    
    describe "get" do
      before(:each) do
        do_new
      end
      
      describe "when http get successful" do
        before(:each) do
          @response = "foo"
          @client.stub!(:get).and_return @response
        end
        
        it "creates representation with response text" do
          @media_type.should_receive(:representation).with @response
          @link.get
        end
        
        it "returns the representation" do
          @link.get.should == @representation
        end
      end
    end
  end
end
