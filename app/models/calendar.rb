class Calendar < ActiveRecord::Base
  attr_accessible :name, :key,:visib,:fee_required,:disabled
end
