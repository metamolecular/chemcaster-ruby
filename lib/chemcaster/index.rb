require 'chemcaster/representation'

module Chemcaster
  class Index < Representation
    def initialize hash
      super
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
