require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Registry do
  before(:each) do
    @test_class = Registry
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'name' => 'foo',
        'deletable' => true
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'structures' => mock(Index),
        'queries' => mock(Index),
        'substances' => mock(Index)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end
