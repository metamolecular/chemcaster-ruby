module Chemcaster
  class Structure < Item
    attributes :name, :serialization
    resources :images, :registry
  end
end