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
      @media_class = mock(Class, :name => 'Foo')
      @client = mock(RestClient::Resource, :get => nil)
      RestClient::Resource.stub!(:new).and_return(@client)
      MediaType.stub!(:locate).and_return @media_class
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
          @response = "{}"
          @representation = mock(Object)
          @media_class.stub!(:new).and_return(@representation)
          @client.stub!(:get).and_return @response
        end
        
        it "creates the representation from response" do
          @media_class.should_receive(:new).with(JSON(@response))
          @link.get
        end
        
        it "returns the representation" do
          @link.get.should == @representation
        end
      end
    end
  end
end
