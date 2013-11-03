class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason ,:place
  belongs_to :user
end
