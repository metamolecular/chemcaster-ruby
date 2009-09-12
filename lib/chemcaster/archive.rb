module Chemcaster
  class Archive < Item
    attributes :created_at, :done
    resources :zipfile, :registry
  end
end