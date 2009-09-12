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
  
  describe "standard representation", :shared => true do
    
  end
  
  describe "representation with all attributes", :shared => true do
    before(:each) do
      @hash = {
        hash_name => @attributes
      }
      do_new
    end
    
    def do_new
      @item = @test_class.new mock(Link), @hash
    end
    
    def hash_name
      @test_class.to_s.gsub(/Chemcaster::/, '').downcase
    end
    
    it "has all attributes" do
      @attributes.each_key do |attribute|
        @item.send(attribute).should == @attributes[attribute]
      end
    end
  end
  
  describe "representation with all resources", :shared => true do
    before(:each) do
      @hash = {}

      @resources.each_key do |name|
        @hash[name] = {'name' => name}
        Link.stub!(:new).with(@hash[name]).and_return mock(Link, :get => @resources[name])
      end

      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
    
    def do_new
      @item = @test_class.new mock(Link), @hash
    end
        
    it "has all resources" do
      @resources.each_key do |name|
        @item.send(name).should == @resources[name]
      end
    end
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
