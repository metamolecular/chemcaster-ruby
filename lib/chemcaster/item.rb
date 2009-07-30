module Chemcaster
  class Item
    def initialize hash
      load_hash hash
    end
    
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
      @index = Link.new hash['index']
      @update = Link.new hash['update']
      @destroy = Link.new hash['destroy']
    end
  end
end
