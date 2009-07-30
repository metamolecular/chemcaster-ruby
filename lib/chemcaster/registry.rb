require 'chemcaster/representation'

module Chemcaster
  class Registry < Representation
    attr_reader :index
    attr_reader :create
    attr_accessor :name
    attr_reader :queries
    attr_reader :structures
    
    def initialize link
      @link = link
    end
    
    def load
      hash = @link.get
      @index = Link.new hash['index']
      @create = Link.new hash['create']
      @name = hash['name']
      @queries = Link.new hash['queries']
      @structures = Link.new hash['structures']
    end
  end
end