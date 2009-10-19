module Chemcaster
  class Execution < Item
    attributes :cursor, :reverse, :next_cursor, :previous_cursor
    resources :executable
    attr_accessor :substances
    
    protected
    
    def load_hash hash
      super
      
      hash['substances'] ||= []
      
      @substances = hash['substances'].inject([]) do |result, substance_array|
        result << substance_array.inject([]) do |substances, substance_link|
          substances << Link.new(substance_link)
        end
      end
    end
  end
end