require 'chemcaster/representation'

module Chemcaster
  class Registry < Representation
    attr_reader :index
    attr_accessor :name
    attr_reader :queries
    attr_reader :structures
    
    def initialize link
      @link = link
    end
    
    def load
      hash = @link.get
      @index = Link.new hash['index']
      @name = hash['name']
      @queries = Link.new hash['queries']
      @structures = Link.new hash['structures']
    end
  end
end