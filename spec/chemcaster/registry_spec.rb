require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
  describe "new" do
    before(:each) do
    end
    
    def do_new
      @registry = Registry.new @link
    end
    
    describe "load" do
      before(:each) do
        @link = mock(Link, :get => {})
      end
      
      describe "with a working link" do
        before(:each) do
          @name = 'foo'
          @hash = {}
          @response = {
            'name' => @name,
            'index' => @hash,
            'queries' => @hash,
            'structures' => @hash
          }
          @new_link = mock(Link)
          Link.stub!(:new).and_return(@new_link)
          @link.stub!(:get).and_return @response
          do_new
        end
      
        it "assigns index" do
          @registry.load
          @registry.index.should == @new_link
        end
        
        it "assigns name" do
          @registry.load
          @registry.name.should == @name
        end
        
        it "assigns queries" do
          @registry.load
          @registry.queries.should == @new_link
        end
        
        it "assigns structures" do
          @registry.load
          @registry.structures.should == @new_link
        end
      end
    end
  end
  
  #  describe "with a link" do
  #    before(:each) do
  #      @link_atts = {
  #        'name' => 'foo',
  #        'uri' => 'http://foo.com',
  #        'media_type' => 'text/plain'
  #      }
  #      @link.stub!(:get).and_return 'index' => @link_atts
  #    end
  #    
  #    it "has a link" do
  #      do_new
  #      @registry.link.should == @link
  #    end
  #    
  #    describe "representing an index" do
  #      before(:each) do
  #        @index_link = mock(Link)
  #        Link.stub!(:new).and_return @index_link
  #      end
  #      
  #      it "creates index link" do
  #        Link.should_receive(:new).with(@link_atts)
  #        do_new
  #      end
  #    end
  #  end
end
