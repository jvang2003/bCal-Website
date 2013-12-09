class RequestMailer < ActionMailer::Base
  default from: "no_reply@bcal.com"
  
  def request_successful(params)
    @info=params
    mail(:to => params["email"] ,:subject => "Room Request")
  end

  def status_changed(request)
    @request=request
    email=@request.email
    mail(:to => email,:subject => "Status Update")
  end

  def collision_detected(calendar,email)
    @calendar=calendar
    mail(:to => email,:subject => "Overbooking")
  end
end
