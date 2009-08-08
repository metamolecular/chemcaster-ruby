require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Item do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @link = mock(Link, :delete => true)
    @item = Item.new @link, @hash
  end
  
  describe "with no attributes" do
    before(:each) do
      do_new
    end
    
    it "raises for index" do
      lambda{@item.index}.should raise_error(LinkNotDefined)
    end
  end
  
  describe "index" do
    before(:each) do
      @hash['index'] = {
        'name' => 'destroy'
      }
      @index_link = mock(Link, :get => nil)
      Link.stub!(:new).with(@hash['index']).and_return @index_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
    
    describe "when successful" do
      before(:each) do
        @index = mock(Index)
        @index_link.stub!(:get).and_return @index
      end
      
      it "gets representation from link" do
        @index_link.should_receive(:get)
        @item.index
      end
      
      it "returns representation" do
        @item.index.should == @index
      end
    end
  end
  
  describe "update" do
    before(:each) do
      do_new
    end
    
    describe "when successful" do
      before(:each) do
        @new_item = mock(Item)
      end
      
      it "puts to link" do
        @link.should_receive(:put).with(@new_item)
        @item.update @new_item
      end
    end
  end
  
  describe "destroy" do
    before(:each) do
      do_new
    end
    
    describe "when successful" do
      before(:each) do

      end
      
      it "deleltes to link" do
        @link.should_receive(:delete)
        @item.destroy
      end
    end
  end
end
