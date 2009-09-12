require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Query do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @query = Query.new mock(Link), @hash
  end
  
  describe "with a serialization" do
    before(:each) do
      @serialization = 'foo'
      @hash['query'] = {
        'serialization' => @serialization
      }
      do_new
    end
    
    it "returns name" do
      @query.serialization.should == @serialization
    end
  end
  
  describe "with registry link" do
    before(:each) do
      @registry = mock(Item)
      @registry_link = mock(Link, :get => @registry)
      @hash['registry'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['registry']).and_return @registry_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns query images" do
      @query.registry.should == @registry
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
      
    it "returns query images" do
      @query.images.should == @images
    end
  end
  
  describe "with executions link" do
    before(:each) do
      @executions = mock(Index)
      @executions_link = mock(Link, :get => @executions)
      @hash['executions'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['executions']).and_return @executions_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns query images" do
      @query.executions.should == @executions
    end
  end
end