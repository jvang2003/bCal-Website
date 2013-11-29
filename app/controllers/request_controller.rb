class RequestController < ApplicationController
  def new
  end

  def create
    date=params["date"].split("/")
    to_pass = {}
    to_pass[:people] = params[:people]
    to_pass[:details] = params[:details]
    to_pass[:reason] = params[:reason]
    to_pass[:place] = params[:place]
    to_pass[:course_related] = params[:course_related]
    to_pass[:accept_different_room] = params[:accept_different_room]
    to_pass[:department] = params[:department]
<<<<<<< HEAD
    to_pass[:time] = DateTime.new(date[2].to_i,date[0].to_i,date[1].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i, 0,"-8")
=======
    to_pass[:time] = DateTime.new(params["date"]["(1i)"].to_i,params["date"]["(2i)"].to_i,params["date"]["(3i)"].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i, 0,"-8")
>>>>>>> 1d7d3a6a0050d13f4580f52b1ce76683d6eba692
    to_pass[:email]=params[:email]
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
     if (params[:status])
       RequestMailer.status_changed(@request).deliver
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
