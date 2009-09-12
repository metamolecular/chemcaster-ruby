require File.dirname(__FILE__) + '/../chemcaster/item'

module Chemcaster
  class Registry < Item
    attributes :name, :deletable
    resources :queries, :structures, :substances
  end
end