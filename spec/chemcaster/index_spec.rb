require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Index do
  def do_new
    @index = Index.new @link
  end
  
  def do_load
    @index.load
  end
  
  describe "load" do
    before(:each) do
      @response = {}
      @link = mock(Link, :get => @response)
    end
    
    describe "with a valid link response" do
      before(:each) do
        @create_hash = {
          :name => 'create'
        }
        @response['create'] = @create_hash
        @create_link = mock(Link)
        Link.stub!(:new).with(@create_hash).and_return(@create_link)
        do_new
        do_load
      end
    
      it "assigns create link" do
        @index.create.should == @create_link
      end
    end
  end
end