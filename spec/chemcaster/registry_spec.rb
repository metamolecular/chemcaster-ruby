require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
      
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
