module Chemcaster
  class Execution < Item
    attributes :cursor, :reverse, :next_cursor, :previous_cursor
    resources :executable
  end
end