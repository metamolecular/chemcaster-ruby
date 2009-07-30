require 'chemcaster/index'

module Chemcaster
  class RegistryIndex < Index
    attr_reader :registries
    
    protected
    
    def load_hash atts
      super
      @registries = load_registries atts
    end
    
    private
    
    def load_registries atts
      atts['registries'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end