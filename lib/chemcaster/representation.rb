module Chemcaster
  class Representation
    @@resource_ids = []
    @@attribute_ids = []
    attr_accessor :attributes
    
    def initialize hash
      @attributes = {}
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
