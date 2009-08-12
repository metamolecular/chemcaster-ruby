require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Image do
  before(:each) do
    @atts = {}
  end
  
  def do_new
    @link = mock(Link)
    @image = Image.new @link, 'image' => @atts
  end
  
  describe "with required attributes" do
    before(:each) do
      @atts['width'] = 200
      @atts['height'] = 200
    end
    
    it "has width" do
      do_new
      @image.width.should == 200
    end
    
    it "has height" do
      do_new
      @image.height.should == 200
    end
  end
end
