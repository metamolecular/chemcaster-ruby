require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Index do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @link = mock(Link)
    @index = Index.new @link, @hash
  end
  
  describe "with all valid attributes" do
    before(:each) do
      @hash['create'] = {
        'name' => 'create Foo',
        'uri' => 'http://foo.com',
        'media_type' => 'text/foo'
      }
      @hash['items'] = [
        {
          'name' => 'items listing',
          'uri' => 'http://foo.com',
          'media_type' => 'text/foo'
        }
      ]
    end
    
    describe "item links" do
      before(:each) do
        @item_link = mock(Link)
        @items = [@item_link]
        Link.stub!(:new).and_return @item_link
        do_new
      end
      
      it "gives item links" do
        @index.item_links.should == @items
      end
    end
    
    describe "create" do
      before(:each) do
        @item = mock(Item)
        Link.stub!(:new).and_return(@create)
        do_new
      end
      
      describe "when successful" do
        before(:each) do
          @link.stub!(:post).and_return(@new_item)
        end
        
        it "posts representation to link" do
          @link.should_receive(:post).with(@item)
          @index.create(@item)
        end
      end
    end
  end
end