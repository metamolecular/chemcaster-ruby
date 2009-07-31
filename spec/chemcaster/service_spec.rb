require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Service do
  describe "connnect" do
    before(:each) do
      @uri = 'http://example.com'
      @media_type = 'application/example'
      @options = {
        :user => 'joe@example.com',
        :password => 'secret'
      }
    end
    
    def do_connect
      Service.connect(@uri, @media_type, @options)
    end
    
    describe "when successful" do
      before(:each) do
        @link = mock(Link)
        Link.stub!(:new).and_return @link
      end
      
      it "returns link" do
        do_connect.should == @link
      end
      
      it "logs in" do
        Login.should_receive(:login).with(@options[:user], @options[:password])
        do_connect
      end
    end
  end
end
