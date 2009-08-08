require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Site do
  describe "connnect" do
    before(:each) do
      @uri = 'http://example.com'
      @options = {
        :user => 'joe@example.com',
        :password => 'secret'
      }
    end
    
    def do_connect
      Site.connect(@uri, @options)
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
      
      it "logs in" do
        Login.should_receive(:login).with(@options[:user], @options[:password])
        do_connect
      end
    end
  end
end
