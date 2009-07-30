module Chemcaster
  class Index    
    def initialize hash
      load_hash hash
    end
    
    def create representation
      @create.post representation
    end
    
    protected
    
    def load_hash atts
      @create = Link.new(atts['create'])
    end
  end
end
