require 'chemcaster/index'

module Chemcaster
  class RegistryIndex < Index
    attr_reader :link
    attr_reader :registries
    attr_reader :create
    
#    def initialize link
#      @link = link
#    end
    
    def load
      super
      @registries = load_registries
    end
    
    private
    
    def load_registries
      @atts['registries'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end