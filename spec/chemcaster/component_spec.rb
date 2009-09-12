require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Component do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @component = Component.new mock(Link), @hash
  end
  
  describe "with multiplier" do
    before(:each) do
      @multiplier = 1.0
      @hash['component'] = {
        'multiplier' => @multiplier
      }
      do_new
    end
    
    it "returns nultiplier" do
      @component.multiplier.should == @hash['component']['multiplier']
    end
  end
  
  describe "with structure link" do
    before(:each) do
      @structure = mock(Item)
      @structure_link = mock(Link, :get => @structure)
      @hash['structure'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['structure']).and_return @structure_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns components index" do
      @component.structure.should == @structure
    end
  end
  
  describe "with substance link" do
    before(:each) do
      @substance = mock(Item)
      @substance_link = mock(Link, :get => @substance)
      @hash['substance'] = {'name' => 'foo'}
      Link.stub!(:new).with(@hash['substance']).and_return @substance_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
      
    it "returns components index" do
      @component.substance.should == @substance
    end
  end
end
