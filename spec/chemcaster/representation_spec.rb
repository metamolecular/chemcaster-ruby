require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Representation do  
  before(:each) do
    @link = mock(Link)
    @atts = {}
  end
  
  after(:each) do
    Representation.attribute_ids.clear
  end
  
  def do_new
    @representation = Representation.new @link, @atts
  end
  
  describe "with one attribute" do
    before(:each) do
      @atts['representation'] = {'bar' => 'baz'}
      @class = mock(Class)
      Representation.attributes :bar
    end
    
    it "has the attribute" do
      do_new
      @representation.attributes.should == @atts['representation']
    end
    
    it "returns the correct json" do
      do_new
      @representation.to_json.should == JSON(@atts)
    end
    
#    describe "to json" do
#      before(:each) do
#        do_new
#      end
#    
#      it "returns the correct value" do
#        @representation.to_json.should == JSON({'foo' => {'bar' => 'baz'}})
#      end
#    end
  end
end
