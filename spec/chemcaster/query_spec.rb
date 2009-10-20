require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Query do
  before(:each) do
    @test_class = Query
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'serialization' => 'foo',
        'mode' => 'bar'
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'images' => mock(Index),
        'executions' => mock(Index),
        'registry' => mock(Registry)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end