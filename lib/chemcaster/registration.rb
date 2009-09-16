require File.dirname(__FILE__) + '/../chemcaster/item'

module Chemcaster
  class Registration < Item
    attributes :templates
    resources :substance, :registry
  end
end
