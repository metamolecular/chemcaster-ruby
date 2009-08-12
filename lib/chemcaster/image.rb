module Chemcaster
  class Image < Item
    attributes :width, :height, :data
    resources :imageable
  end
end
