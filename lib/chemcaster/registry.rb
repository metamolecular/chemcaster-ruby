require File.dirname(__FILE__) + '/../chemcaster/item'

module Chemcaster
  class Registry < Item
    attributes :name, :deletable
    resources :service, :queries, :structures, :substances,
      :archives, :registrations
  end
end