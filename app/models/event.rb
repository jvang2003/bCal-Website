class Event < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :request
end
