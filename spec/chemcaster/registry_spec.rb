require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @registry = Registry.new @hash
  end
  
  describe "with all valid attributes" do
    before(:each) do
      @name = 'foo'
      @hash['name'] = @name
      Link.stub!(:new).with(nil).and_return(mock(Link))
      do_new
    end
    
    it "returns name" do
      @registry.name.should == @name
    end
  end
end
