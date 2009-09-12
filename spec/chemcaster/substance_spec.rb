require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Substance do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @substance = Substance.new mock(Link), @hash
  end
  
  describe "with a serialization" do
    before(:each) do
      @serialization = 'foo'
      @hash['substance'] = {
        'serialization' => @serialization
      }
      do_new
    end
    
    it "returns name" do
      @substance.serialization.should == @hash['substance']['serialization']
    end
  end
  
  describe "with an inchi" do
    before(:each) do
      @inchi = 'foo'
      @hash['substance'] = {
        'inchi' => @inchi
      }
      do_new
    end
    
    it "returns name" do
      @substance.inchi.should == @hash['substance']['inchi']
    end
  end
  
  describe "with components link" do
    before(:each) do
      @components = mock(Index)
      @components_link = mock(Link, :get => @components)
      @hash['components'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['components']).and_return @components_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns components index" do
      @substance.components.should == @components
    end
  end
  
    describe "with images link" do
    before(:each) do
      @images = mock(Index)
      @images_link = mock(Link, :get => @images)
      @hash['images'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['images']).and_return @images_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns components index" do
      @substance.images.should == @images
    end
  end
  
  describe "with registry link" do
    before(:each) do
      @registry = mock(Index)
      @registry_link = mock(Link, :get => @registry)
      @hash['registry'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['registry']).and_return @registry_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns registry" do
      @substance.registry.should == @registry
    end
  end
end
