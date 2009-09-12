module Chemcaster
  class Substance < Item
    attributes :serialization, :inchi
    resources :components, :registry, :images
  end
end