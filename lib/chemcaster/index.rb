require 'chemcaster/representation'

module Chemcaster
  class Index < Representation
    attr_accessor :items
    
    def create representation
      @create.post representation
    end
    
    protected
    
    def load_hash atts
      @create = Link.new(atts['create'])
      @items = atts['items'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end
