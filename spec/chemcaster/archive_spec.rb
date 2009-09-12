require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Archive do
  before(:each) do
    @test_class = Archive
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'done' => true,
        'created_at' => Time.now
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'zipfile' => mock(Item),
        'registry' => mock(Registry)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end