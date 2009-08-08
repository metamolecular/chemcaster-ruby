require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Structure do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @structure = Structure.new @hash
  end
  
  describe "with a name" do
    before(:each) do
      @name = 'foo'
      @structure = {
        'name' => @name
      }
      @hash['structure'] = @structure
      do_new
    end
    
    it "returns hash" do
      @structure.to_hash.should == {'name' => @name, 'molfile' => nil}
    end
    
    it "returns name" do
      @structure.name.should == @name
    end
  end
  
  describe "with a molfile" do
    before(:each) do
      @molfile = 'foo'
      @structure = {
        'molfile' => @molfile
      }
      @hash['structure'] = @structure
      do_new
    end
    
    it "returns molfile" do
      @structure.to_hash.should == {'molfile' => @molfile, 'name' => nil}
    end
    
    it "returns name" do
      @structure.molfile.should == @molfile
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