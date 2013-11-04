class RequestMailer < ActionMailer::Base
  default from: "no_reply@bcal.com"
  
  def request_successful(params)
    @info=params
    mail(:to => params["email"] ,:subject => "Room Request")
  end
end
