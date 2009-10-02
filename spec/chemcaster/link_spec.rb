require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Chemcaster::Link do  
  def login
    @user = 'joe@example.com'
    @pass = 'secret'
    Service.stub!(:username).and_return(@user)
    Service.stub!(:password).and_return(@pass)
    Service.stub!(:root_ca).and_return 'foo'
    File.stub!(:exists?).with(Service.root_ca).and_return true
  end
  
  def mock_uri
    @uri_string = 'http://example.com/foo'
    @uri = mock(URI, :host => 'example.com', :path => '/foo', :port => 80, :scheme => 'https')
    URI.stub!(:parse).and_return @uri
  end
  
  def mock_request
    @request = mock(Net::HTTPGenericRequest)
    
    if @method == "get"
      Net::HTTP::Get.stub!(:new).with(@uri.path).and_return @request
    elsif @method == "put"
      @request.stub!(:body=)
      @request.stub!(:content_type=)
      Net::HTTP::Put.stub!(:new).with(@uri.path).and_return @request
    elsif @method == "post"
      @request.stub!(:body=)
      @request.stub!(:content_type=)
      Net::HTTP::Post.stub!(:new).with(@uri.path).and_return @request      
    elsif @method == "delete"
      Net::HTTP::Delete.stub!(:new).with(@uri.path).and_return @request
    end
    
    @request.stub!(:[]=).with('accept', @media_name)
    @request.stub!(:basic_auth).with(@user, @pass)
  end
  
  def mock_response
    @representation = mock(Representation)
    @response = mock(Net::HTTPResponse, :body => "{}", :code => 200,
      :content_type => 'application/vnd.com.chemcaster.Foo+json')
  end
  
  def mock_media_type
    @media_name = 'text/plain'
    @media_class = mock(Class, :mime_type => 'application/foo')
    @media_key = 'foo'
    MediaType.stub!(:representation).and_return @media_class
    MediaType.stub!(:hash_key).and_return(@media_key)    
  end
  
  def mock_http
    @http = mock(Net::HTTP, :use_ssl= => true, :verify_mode= => true, :ca_path= => true)
    @http.stub!(:start).and_yield(@http)
    @http.stub!(:request).with(@request).and_return @response
    Net::HTTP.stub!(:new).and_return @http
  end
  
  def setup_http
    login
    mock_uri
    mock_media_type
    mock_request
    mock_response
    mock_http
    @link = Link.new({'name' => 'foo', 'uri' => @uri_string, 'media_type' => @media_name})
    @media_class.stub!(:new).with(@link, JSON.parse(@response.body)).and_return(@representation)
  end
  
  describe "http request", :shared => true do    
    it "sets accept header" do
      @request.should_receive(:[]=).with('accept', @media_name)
      @action.call
    end
    
    it "sets basic auth" do
      @request.should_receive(:basic_auth).with(@user, @pass)
      @action.call
    end
    
    it "makes the request" do
      @http.should_receive(:request).with(@request).and_return @response
      @action.call
    end
    
    describe "when using non-chemcaster content_type" do
      before(:each) do
        @response.stub!(:content_type).and_return 'application/foo'
        @response.stub!(:body).and_return ""
        @media_class.stub!(:new).with(@link, @response.body).and_return(@representation)
      end
      
      it "doesn't parse json" do
        JSON.should_not_receive(:parse)
        @action.call
      end
    end
    
    describe "when error response" do
      before(:each) { @response.stub!(:code).and_return(400)}
      
      it "raises" do
        lambda{@action.call}.should raise_error(HTTPError)
      end
    end
  end
  
  describe "http send representation", :shared => true do
    it "sets request body" do
      @request.should_receive(:body=).with({@media_key => @new_representation_attributes}.to_json)
      @action.call
    end
    
    it "sets content type" do
      @request.should_receive(:content_type=).with(@media_name)
      @action.call
    end
  end
  
  describe "get" do
    before(:each) do
      @method = "get"
      @action = lambda{@link.get}
      setup_http
    end
    
    it_should_behave_like "http request"
  end
  
  describe "put" do
    before(:each) do
      @new_representation_attributes = mock(Representation, :attributes => {})
      @method = "put"
      @action = lambda{@link.put @new_representation_attributes}
      setup_http
    end
    
    it_should_behave_like "http request"
    it_should_behave_like "http send representation"
  end
  
  describe "post" do
    before(:each) do
      @new_representation_attributes = {:foo => 'bar'}
      @method = "post"
      @action = lambda{@link.post @new_representation_attributes}
      setup_http
    end
    
    it_should_behave_like "http request"
    it_should_behave_like "http send representation"
  end
  
  describe "delete" do
    before(:each) do
      @method = "delete"
      @action = lambda{@link.delete}
      setup_http
    end
    
    it_should_behave_like "http request"
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
end
