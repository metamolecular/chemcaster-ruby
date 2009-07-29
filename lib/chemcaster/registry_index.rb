module Chemcaster
  class RegistryIndex
    attr_reader :link
    attr_reader :registries
    
    def initialize link
      @link = link
      @registries = load_registries
    end
    
    def load_registries
      atts = @link.get
      atts['registries'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end