class RequestController < ApplicationController
  def new
  end

  def create
    to_pass = {}
    to_pass[:people] = params[:people]
    to_pass[:details] = params[:details]
    to_pass[:reason] = params[:reason]
    to_pass[:place] = params[:place]
    to_pass[:course_related] = params[:course_related]
    to_pass[:accept_different_room] = params[:accept_different_room]
    to_pass[:department] = params[:department]
    to_pass[:time] = DateTime.new(params["date"]["(1i)"].to_i,params["date"]["(2i)"].to_i,params["date"]["(3i)"].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i)
    to_pass[:status] = "pending"
    
    Request.create! to_pass
    RequestMailer.request_successful(params).deliver

    flash[:notice]="Request has been submitted"
    redirect_to calendars_path
  end

  def show
  	@requests = Request.all
  	# @requests = Request.all(:user_id => @user_id) #TODO: ACTUALLY MAKE THIS USE THE USER ID!!!!
  end

  def edit
     @request = Request.find(params[:id])
     prev_status = @request.status
     @request.status = params[:status] unless params[:status] == nil
     calendar = Calendar.find_by_name(@request.place)
     @request.calendar = calendar if @request.calendar == nil
     @request.save!
    
     #if (params[:status] != nil) #updating the request status
       #event = {'summary' => @request.details, 'location' => @request.place, 'start' => {'dateTime' => @request.time.to_datetime.rfc3339}, 'end' => {'dateTime' => @request.time.to_datetime.rfc3339}, 'attendees' => @request.people}
     #  if (params[:status] == "approved" and calendar.access_token != nil)
      #     print(@request.time)
      #     event = {"summary" => @request.reason, "location" => @request.place, "start" => {"date" => "2013-11-26"}, "end" => {"date" => "2013-11-26"}, 'location' => @request.place}
     #      result = calendar.client.execute(:api_method => calendar.gcalendar.events.insert,
     #   :parameters => {:calendarId => calendar.email}, :body => JSON.dump(event), :headers => {'Content-Type' => 'application/json'})
     #      #print("the result is nil" + result.data)
     #  end
     #  if (params[:status] == "denied" and calendar.access_token != nil and prev_status == "approved")
     #      event = {"summary" => @request.reason, "location" => @request.place, "start" => {"date" => "2013-11-26"}, "end" => {"date" => "2013-11-26"}, 'location' => @request.place}
           #result = calendar.client.execute(:api_method => calendar.gcalendar.events.delete, :parameters => {:calendarID => calendar.id, :eventId => @event.id})
      # end
       #flash[:notice] = "Request Status has been updated."
       #redirect_to show_requests_path
     #end
     if (params[:status])
       if (prev_status != "approved" and @request.status == "approved" and calendar.access_token != nil)
         @event = Event.new
         @request.event = @event
         @request.event.update_gcal
       elsif (params[:status] and (@request.status == "rejected" or @request.status == "pending") and calendar.access_token != nil)
         @request.event.delete_event
         @request.event.destroy
       end
       flash[:notice] = "Request Status has been updated."
       redirect_to show_requests_path
    end
  end
end
