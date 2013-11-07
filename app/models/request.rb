class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :time, :status

  belongs_to :user
  has_one :event
end
