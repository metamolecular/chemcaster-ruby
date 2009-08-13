require File.dirname(__FILE__) + '/../chemcaster/item'

module Chemcaster
  class Registry < Item
    attributes :name
    resources :queries, :structures
  end
end