require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @registry = Registry.new @hash
  end
  
  describe "with a name" do
    before(:each) do
      @name = 'foo'
      @registry = {
        'name' => @name
      }
      @hash['registry'] = @registry
      do_new
    end
    
    it "returns hash" do
      @registry.to_hash.should == {'name' => @name}
    end
    
    it "returns name" do
      @registry.name.should == @name
    end
  end
end
