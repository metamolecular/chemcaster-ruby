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
      Link.stub!(:new).with(nil).and_return mock(Link)
    end
    
    describe "creating" do
      before(:each) do
        @atts = {'name' => 'foo'}
        do_new
      end
      
      it "sends post to create link" do
        @create_link.should_receive(:post).with(@atts)
        @index.create @atts
      end
    end
    
    describe "and parent resource" do
      before(:each) do
        @hash['parent'] = {
          'name' => 'parent',
          'uri' => 'http://foo.com',
          'media_type' => 'text/foo'
        }
        @parent_link = mock(Link)
        Link.stub!(:new).with(@hash['parent']).and_return @parent_link
        do_new
      end
      
      it "sends get to parent link" do
        @parent_link.should_receive(:get)
        @index.parent
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
        @item = mock(Item)
        @item_link = mock(Link, :get => @item)
        Link.stub!(:new).and_return @item_link
      end
          
      it "gives item link" do
        do_new
        @index.item_links.should == [@item_link]
      end
      
      it "has size" do
        do_new
        @index.size.should == 1
      end
      
      it "fetches item" do
        do_new
        @index[0].should == @item
      end
    end
  end
end