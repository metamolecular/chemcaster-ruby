require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Image do
  before(:each) do
    @test_class = Image
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'width' => 100,
        'height' => 100,
        'format' => 'image/png',
        'data' => 'sdlfkjsdlfjlsdjf'
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'imageable' => mock(Structure)
      }
    end
    it_should_behave_like "representation with all resources"
  end
end