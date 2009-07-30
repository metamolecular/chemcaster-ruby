module Chemcaster
  class RegistryIndex
    attr_reader :link
    attr_reader :registries
    attr_reader :post
    
    def initialize link
      @link = link
    end
    
    def load
      atts = @link.get
      @registries = load_registries atts
      @post = Link.new(atts['post'])
    end
    
    private
    
    def load_registries atts
      atts['registries'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end