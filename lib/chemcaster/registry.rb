require 'chemcaster/item'

module Chemcaster
  class Registry < Item
    attr_accessor :name
    
    def to_hash
      super.merge('name' => name)
    end
    
    protected
    
    def load_hash hash
      super
      @name = hash['name']
    end
  end
end