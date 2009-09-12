module Chemcaster
  class Component < Item
    attributes :multiplier
    resources :structure, :substance
  end
end
