class Calendar < ActiveRecord::Base
  has_many :request
  
  attr_accessible :name, :key, :visib, :fee_required, :disabled
end