module Chemcaster
  class Structure < Item
    attributes :serialization, :inchi
    resources :images, :registry, :components
  end
end