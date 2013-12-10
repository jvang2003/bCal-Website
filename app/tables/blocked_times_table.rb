require 'helpers'
include TableHelpers

class BlockedTimesTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :start_time, :end_time

  common_actions
end

