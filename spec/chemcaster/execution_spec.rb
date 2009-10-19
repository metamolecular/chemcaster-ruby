require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/representation_spec")

describe Execution do
  before(:each) do
    @test_class = Execution # must be a better way...
  end
  
  describe "attributes" do
    before(:each) do
      @attributes = {
        'cursor' => 'foo',
        'reverse' => true,
        'next_cursor' => 'bar',
        'previous_cursor' => 'baz'
      }
    end
    it_should_behave_like "representation with all attributes"
  end
  
  describe "resources" do
    before(:each) do
      @resources = {
        'executable' => mock(Query)
      }
    end
    it_should_behave_like "representation with all resources"
  end
  
  describe "results" do
    before(:each) do
      @hash = {
        'substances' => [
          [
            {
              'name' => 'result',
              'uri' => 'http://example.com',
              'media_type' => 'application/vnd.com.chemcaster.Structure+json'
            }
          ]
        ]
      }
      @link = mock(Link)
      Link.stub!(:new).and_return @link
      @execution = Execution.new mock(Link), @hash
    end
    
    it "has results" do
      @execution.substances.should == [[@link]]
    end
  end
end