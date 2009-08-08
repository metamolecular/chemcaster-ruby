module Chemcaster
  class Structure < Item
    attributes :name, :molfile
    resources :images
  end
end