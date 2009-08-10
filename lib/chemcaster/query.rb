module Chemcaster
  class Query < Item
    attributes :molfile
    resources :images, :registry
  end
end