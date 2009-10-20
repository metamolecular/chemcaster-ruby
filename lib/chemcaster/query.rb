module Chemcaster
  class Query < Item
    attributes :serialization, :mode
    resources :images, :registry, :executions
  end
end