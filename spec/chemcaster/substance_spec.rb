require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Substance do
  before(:each) do
    @test_class = Substance
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'serialization' => 'foo',
        'inchi' => 'bar'
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'registry' => mock(Registry),
        'components' => mock(Index)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end
