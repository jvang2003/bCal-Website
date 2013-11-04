class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :time

  belongs_to :user
  has_one :event
end
