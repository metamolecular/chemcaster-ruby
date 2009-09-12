require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @registry = Registry.new mock(Link), @hash
  end
  
  describe "with a name and deletable" do
    before(:each) do
      @name = 'foo'
      @registry = {
        'name' => @name,
        'deletable' => true
      }
      @hash['registry'] = @registry
      Link.stub!(:new).and_return mock(Link)
      do_new
    end
    
    it "returns name" do
      @registry.name.should == @name
    end
    
    it "returns deletable" do
      @registry.deletable.should == true
    end
  end
  
  describe "with structures link" do
    before(:each) do
      @structures = mock(Index)
      @structures_link = mock(Link, :get => @structures)
      @hash['structures'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['structures']).and_return @structures_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns structures index" do
      @registry.structures.should == @structures
    end
  end
  
  describe "with queries link" do
    before(:each) do
      @queries = mock(Index)
      @queries_link = mock(Link, :get => @queries)
      @hash['queries'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['queries']).and_return @queries_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
    
    it "returns queries index" do
      @registry.queries.should == @queries
    end
  end
  
  describe "with substances link" do
    before(:each) do
      @substances = mock(Index)
      @substances_link = mock(Link, :get => @substances)
      @hash['substances'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['substances']).and_return @substances_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
    
    it "returns queries index" do
      @registry.substances.should == @substances
    end
  end
end
