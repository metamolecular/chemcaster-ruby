require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe RegistryIndex do 
  def do_new
    @index = RegistryIndex.new @link
  end
  
  describe "with a link" do
    before(:each) do
      @link = mock(Link, :get => {'registries' => []})
    end
    
    it "has link" do
      do_new
      @index.link.should == @link
    end
    
    describe "representing two registries" do
      before(:each) do
        @registry_atts = [
          {
            'name' => 'foo',
            'uri' => 'http://foo.com',
            'media_type' => 'application/foo'
          },
          {
            'name' => 'bar',
            'uri' => 'http://bar.com',
            'media_type' => 'application/bar'
          }
        ]
        @link.stub!(:get).and_return({'registries' => @registry_atts})
        @registry_link1 = mock(Link)
        @registry_link2 = mock(Link)
        Link.stub!(:new).and_return @registry_link1, @registry_link2
      end
      
      it "creates both links" do
        Link.should_receive(:new).once.with(@registry_atts[0]).ordered
        Link.should_receive(:new).once.with(@registry_atts[1]).ordered
        do_new
      end
      
      it "has both links" do
        do_new
        @index.registries.should == [@registry_link1, @registry_link2]
      end
    end
    
    describe "that raises on get" do
      before(:each) do
        @link.stub!(:get).and_raise
      end
      
      it "raises" do
        lambda{do_new}.should raise_error
      end
    end
  end
end