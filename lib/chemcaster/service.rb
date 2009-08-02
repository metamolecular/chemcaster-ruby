require 'chemcaster/representation'

module Chemcaster
  class Service < Representation
    attr_accessor :registries
    
    protected
    
    def load_hash hash
      super
      @registries = Link.new hash['registries']
    end
  end
end