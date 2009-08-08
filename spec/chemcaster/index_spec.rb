require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Index do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @index = Index.new @hash
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
        @new_item = mock(Item)
        @create = mock(Link, :post => nil)
        Link.stub!(:new).and_return(@create)
        Item.stub!(:new).and_return(@new_item)
        do_new
      end
      
      describe "when successful" do
        before(:each) do
          @create.stub!(:post).and_return(@new_item)
        end
        
        it "posts representation to create link" do
          @create.should_receive(:post).with(@item)
          @index.create(@item)
        end
      
        it "returns representation" do
          @index.create(@item).should == @new_item
        end
      end
    end
  end
end