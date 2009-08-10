require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Query do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @query = Query.new mock(Link), @hash
  end
  
  describe "with a molfile" do
    before(:each) do
      @molfile = 'foo'
      @hash['query'] = {
        'molfile' => @molfile
      }
      do_new
    end
    
    it "returns name" do
      @query.molfile.should == @molfile
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
end