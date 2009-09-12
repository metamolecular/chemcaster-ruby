module Chemcaster
  class Image < Item
    attributes :width, :height, :data, :format
    resources :imageable
  end
end
