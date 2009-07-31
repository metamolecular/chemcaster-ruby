require 'chemcaster/item'

module Chemcaster
  class Registry < Item
    attr_accessor :name
    
    protected
    
    def load_hash hash
      super
      @name = hash['name']
    end
  end
end