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
      #      @hash['create'] = {
      #        'name' => 'create Foo',
      #        'uri' => 'http://foo.com',
      #        'media_type' => 'text/foo'
      #      }
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
  end
  
  describe "create" do
    before(:each) do
      @hash['resource'] = {
        'name' => 'resource'
      }
      @hash['items'] = [
        {
          'name' => 'items listing',
          'uri' => 'http://foo.com',
          'media_type' => 'text/foo'
        }
      ]
      @resource_link = mock(Link, :post => true)
      Link.stub!(:new).with(@hash['resource']).and_return @resource_link
      Link.stub!(:new).with(@hash['items'][0]).and_return mock(Link)
      @item = mock(Item)
      do_new
    end
      
    describe "when successful" do
        
      it "posts representation to link" do
        @resource_link.should_receive(:post).with(@item)
        @index.create(@item)
      end
    end
  end
end