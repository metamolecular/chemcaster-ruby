require 'chemcaster/representation'

module Chemcaster
  class Item < Representation    
    def index
      @index.get
    end
    
    def update representation
      @update.put representation
    end
    
    def destroy
      @destroy.delete
    end
    
    protected
    
    def load_hash hash
      super
      @index = Link.new hash['index']
      @update = Link.new hash['update']
      @destroy = Link.new hash['destroy']
    end
  end
end
