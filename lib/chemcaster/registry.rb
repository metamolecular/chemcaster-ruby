require 'chemcaster/item'

module Chemcaster
  class Registry < Item
    attr_accessor :name
    
    def structures
      @structures_link.get
    end
    
    def queries
      @queries_link.get
    end
    
    def to_hash
      super.merge('name' => name)
    end
    
    protected
    
    def load_hash hash
      super
      @name = hash['registry']['name'] if hash['registry']
      @structures_link = Link.new hash['structures']
      @queries_link = Link.new hash['queries']
    end
  end
end