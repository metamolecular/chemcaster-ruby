module Chemcaster
  class Execution < Item
    attributes :cursor, :reverse, :next_cursor, :previous_cursor
    resources :executable
    attr_accessor :results
    
    protected
    
    def load_hash hash
      super
      
      hash['results'] ||= []
      
      @results = hash['results'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end