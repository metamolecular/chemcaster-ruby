require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Chemcaster::Link do
  before(:each) do
    @atts = {}
  end
  
  def do_new
    @link = Link.new({'name' => @name, 'uri' => @uri, 'media_type' => @media_name})
  end
  
  def mock_login
    @user = 'joe@example.com'
    @pass = 'secret'
    @login = mock(Login, :user => @user, :password => @pass)
    Login.stub!(:instance).and_return @login
  end
  
  describe "with nil attributes" do
    before(:each) do
      @link = Link.new nil
    end
    
    it "raises with get" do
      lambda{@link.get}.should raise_error(LinkNotDefined)
    end
    
    it "raises with put" do
      lambda{@link.put(mock(Object))}.should raise_error(LinkNotDefined)
    end
    
    it "raises with post" do
      lambda{@link.post(mock(Object))}.should raise_error(LinkNotDefined)
    end
    
    it "raises with delete" do
      lambda{@link.delete}.should raise_error(LinkNotDefined)
    end
  end
  
  describe "with valid attributes" do
    before(:each) do
      @name = 'foo'
      @uri = 'http://example.com'
      @media_name = 'text/plain'
      @media_class = mock(Class, :mime_type => 'application/foo')
      @client = mock(RestClient::Resource, :get => nil, :put => nil)
      mock_login
      RestClient::Resource.stub!(:new).and_return(@client)
      MediaType.stub!(:representation).and_return @media_class
    end
    
    it "creates the client" do
      RestClient::Resource.should_receive(:new).with(@uri, :user => @user, :password => @pass).and_return(@client)
      do_new
    end
    
    it "locates the media type" do
      MediaType.should_receive(:representation).with(@media_name)
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
          @media_class.should_receive(:new).with(@link, JSON(@response))
          @link.get
        end
        
        it "returns the representation" do
          @link.get.should == @representation
        end
      end
    end
    
    describe "put" do
      before(:each) do
        do_new
      end
      
      describe "when http put successful" do
        before(:each) do
          @response = "{}"
          @representation = mock(Object)
          @new_representation = mock(Object, :attributes => {})
          @media_class.stub!(:new).with(@link, JSON(@response)).and_return(@representation)
          @client.stub!(:put).and_return @response
        end
        
        it "creates the representation from response" do
          @media_class.should_receive(:new).with(@link, JSON(@response))
          @link.put(@new_representation)
        end
        
        it "returns the representation" do
          @link.put(@new_representation).should == @representation
        end
      end
    end
    
    describe "post" do
      before(:each) do
        do_new
      end
      
      describe "when http post successful" do
        before(:each) do
          @response = "{}"
          @representation = mock(Representation)
          @new_representation = mock(Representation, :attributes => {})
          @media_class.stub!(:new).with(@link, JSON(@response)).and_return(@representation)
          @client.stub!(:post).and_return @response
          @new_representation.stub!(:class).and_return(Representation)
        end
        
        it "sends the representation" do
          @client.should_receive(:post).with(JSON({'representation' => {}}), :content_type => @media_name, :accept => @media_name)
          @link.post(@new_representation)
        end
        
        it "creates the representation from response" do
          @media_class.should_receive(:new).with(@link, JSON(@response))
          @link.post(@new_representation)
        end
        
        it "returns the representation" do
          @link.post(@new_representation).should == @representation
        end
      end
    end
    
    describe "delete" do
      before(:each) do
        do_new
      end
      
      describe "when http get successful" do
        before(:each) do
          @response = "{}"
          @representation = mock(Object)
          @media_class.stub!(:new).and_return(@representation)
          @client.stub!(:delete).and_return @response
        end
        
        it "creates the representation from response" do
          @media_class.should_receive(:new).with(@link, JSON(@response))
          @link.delete
        end
        
        it "returns the representation" do
          @link.delete.should == @representation
        end
      end
    end
  end
end
