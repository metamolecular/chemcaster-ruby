module Chemcaster
  class Query < Item
    attributes :serialization
    resources :images, :registry, :executions
  end
end