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