require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Item do
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @item = Item.new @hash
  end
  
  describe "with no attributes" do
    before(:each) do
      do_new
    end
    
    it "raises for index" do
      lambda{@item.index}.should raise_error(LinkNotDefined)
    end
    
    it "raises for update" do
      lambda{@item.update(nil)}.should raise_error(LinkNotDefined)
    end
    
    it "raises for destroy" do
      lambda{@item.destroy}.should raise_error(LinkNotDefined)
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
      @hash['update'] = {
        'name' => 'destroy'
      }
      @update_link = mock(Link, :put => nil)
      Link.stub!(:new).with(@hash['update']).and_return @update_link
      Link.stub!(:new).with(nil).and_return mock(Link)
      do_new
    end
    
    describe "when successful" do
      before(:each) do
        @new_item = mock(Item)
        @updated_item = mock(Item)
        @update_link.stub!(:put).with(@new_item).and_return(@updated_item)
      end
      
      it "puts to link" do
        @update_link.should_receive(:put).with(@new_item)
        @item.update @new_item
      end
      
      it "returns representation" do
        @item.update(@new_item).should == @updated_item
      end
    end
  end
  
  describe "destroy" do
    before(:each) do
      @hash['destroy'] = {
        'name' => 'destroy'
      }
      @destroy_link = mock(Link, :delete => nil)
      Link.stub!(:new).with(@hash['destroy']).and_return @destroy_link
      Link.stub!(:new).with(nil).and_return(mock(Link))
      do_new
    end
    
    describe "when successful" do
      before(:each) do
        @index = mock(Index)
        @destroy_link.stub!(:delete).and_return(@index)
      end
      
      it "deleltes to link" do
        @destroy_link.should_receive(:delete)
        @item.destroy
      end
      
      it "returns representation" do
        @item.destroy.should == @index
      end
    end
  end
end
