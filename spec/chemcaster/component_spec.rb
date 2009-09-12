require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Component do
  before(:each) do
    @test_class = Component
  end
  
    describe "attributes" do
    before(:each) do
      @attributes = {
        'multiplier' => 1.0
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'structure' => mock(Structure),
        'substance' => mock(Substance)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end
