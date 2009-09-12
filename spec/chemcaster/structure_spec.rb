require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Structure do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @structure = Structure.new mock(Link), @hash
  end
  
  describe "with a name" do
    before(:each) do
      @name = 'foo'
      @hash['structure'] = {
        'name' => @name
      }
      do_new
    end
    
    it "returns name" do
      @structure.name.should == @hash['structure']['name']
    end
  end
  
  describe "with a molfile" do
    before(:each) do
      @serialization = 'foo'
      @structure = {
        'serialization' => @serialization
      }
      @hash['structure'] = @structure
      do_new
    end
    
    it "returns name" do
      @structure.serialization.should == @serialization
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
      
    it "returns structures index" do
      @structure.images.should == @images
    end
  end
end