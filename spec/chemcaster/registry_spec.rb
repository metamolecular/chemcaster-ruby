require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Registry do
      
  def do_new
    @registry = Registry.new @link
  end
  
  describe "load" do
    before(:each) do
      @link = mock(Link, :get => {})
    end
      
    describe "with a working link" do
      before(:each) do
        @name = 'foo'
        @index_hash = {
          'name' => 'index'
        }
        @create_hash = {
          'name' => 'create'
        }
        @queries_array = [
          {
            'name' => 'query'
          }
        ]
        @structures_array = [
          {
            'name' => 'structure'
          }
        ]
        @response = {
          'name' => @name,
          'index' => @index_hash,
          'create' => @create_hash,
          'queries' => @queries_array,
          'structures' => @structures_array
        }
        @index_link = mock(Link)
        @queries_link = mock(Link)
        @create_link = mock(Link)
        Link.stub!(:new).with(@index_hash).and_return(@index_link)
        Link.stub!(:new).with(@create_hash).and_return(@create_link)
        Link.stub!(:new).with(@queries_array).and_return(@queries_link)
        Link.stub!(:new).with(@structures_array).and_return(@structures_link)
        @link.stub!(:get).and_return @response
        do_new
      end
      
      it "assigns index" do
        @registry.load
        @registry.index.should == @index_link
      end
      
      it "assigns create" do
        @registry.load
        @registry.create.should == @create_link
      end
        
      it "assigns name" do
        @registry.load
        @registry.name.should == @name
      end
        
      it "assigns queries" do
        @registry.load
        @registry.queries.should == @queries_link
      end
        
      it "assigns structures" do
        @registry.load
        @registry.structures.should == @structures_link
      end
    end
  end
end
