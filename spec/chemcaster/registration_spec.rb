require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Registration do
  before(:each) do
    @test_class = Registration
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'templates' => [
          {
            'multiplier' => 1.0,
            'serialization' => 'foobar'
          }
        ]
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'registry' => mock(Registry),
        'substance' => mock(Substance)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end