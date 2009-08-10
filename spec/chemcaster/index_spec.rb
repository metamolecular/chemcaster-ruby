require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Index do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @link = mock(Link)
    @index = Index.new @link, @hash
  end
  
  describe "with create link data" do
    before(:each) do
      @hash['items'] = []
      @hash['create'] = {
        'name' => 'create Foo',
        'uri' => 'http://foo.com',
        'media_type' => 'text/foo'
      }
      @create_link = mock(Link)
      Link.stub!(:new).with(@hash['create']).and_return @create_link
    end
    
    describe "creating" do
      before(:each) do
        @representation = mock(Object)
        do_new
      end
      
      it "sends post to create link" do
        @create_link.should_receive(:post).with(@representation)
        @index.create @representation
      end
    end
    
    describe "and item links" do
      before(:each) do
        @hash['items'] = [
          {
            'name' => 'items listing',
            'uri' => 'http://foo.com',
            'media_type' => 'text/foo'
          }
        ]
        @item_link = mock(Link)
        Link.stub!(:new).and_return @item_link
      end
          
      it "gives item link" do
        do_new
        @index.item_links.should == [@item_link]
      end
    end
  end
end