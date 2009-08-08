module Chemcaster
  class Representation
    @@resource_ids = []
    attr_accessor :attributes
    attr_accessor :resource_names
    
    def initialize hash
      @attributes = {}
      @resource_names = []
      load_hash hash
    end
    
    def to_hash
      @attributes
    end
    
    protected
    
    def load_hash hash
    
    end
  end
end
