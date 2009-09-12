module Chemcaster
  class Substance < Item
    attributes :serialization, :inchi
    resources :components, :registry
  end
end