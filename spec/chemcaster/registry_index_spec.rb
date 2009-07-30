require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe RegistryIndex do 
  before(:each) do
    @hash = {}
  end
  
  def do_new
    @index = RegistryIndex.new @hash
  end
    
  describe "with a valid link response" do
    before(:each) do
      @registry_array = [
        {
          'name' => 'registry'
        }
      ]
      @hash['registries'] = @registry_array
      @registry_link = mock(Link)
      Link.stub!(:new).with(@registry_array[0]).and_return(@registry_link)
      Link.stub!(:new).with(nil).and_return(mock(Link))
    end
    
    describe "instantiating" do
      before(:each) { do_new }
      it "assigns registries" do
        @index.registries.should == [@registry_link]
      end
    end
  end
end