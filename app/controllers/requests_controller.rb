class RequestsController < ApplicationController
  before_filter :require_mine, :only => [:edit, :update, :show]

  def require_mine
    if params[:id] && (not current_user.is_dept_admin?)
      @request ||= Request.find params[:id]
      if @request.user.id != current_user.id
        flash[:error] = "You must be a \"Department Admin\" to view other people's requests."
        redirect_to requests_path and return
      end
    end
  end

  def self.can_view? user
    user && user.role >= 0
  end

  def self.can_crud? user
    user && user.role >= 0
  end

  def new
    @request = Request.new
  end

  def create
    collide=false

    @request = Request.new
    to_pass = handle_params params[:request].pluck Request::FIELDS
    %w(people details reason place course_related accept_different_room department email user_id).each do |attr|
      to_pass[attr] = params[:request][attr]
    end

    time=Time.strptime(params["date"],"%m/%d/%Y")
    to_pass[:start_time] = generate_time("start_time", time)
    to_pass[:finish_time] = generate_time("end_time", time)


    # to_pass[:start_time] = Time.new(time.year,time.month,time.day, hour=params["start_time"]['hour'].to_i, minute=params["start_time"]['min'].to_i,0,"-08:00")
    # to_pass[:finish_time] = Time.new(time.year,time.month,time.day, hour=params['end_time']['hour'], minute=params['end_time']['min'].to_i,0,"-08:00")
    to_pass[:status] = "Pending"
    to_pass[:email] = current_user.email

    if blocked?(to_pass[:start_time], to_pass[:end_time])
      flash[:error] = "Your request was automatically rejected because there is a blocked off time section."
    else
      request = Request.create! to_pass
      RequestMailer.request_successful(request).deliver
      flash[:notice]= "Request has been submitted"
    end
    redirect_to calendars_path
  end

  def index
    filter = params[:filter]

    @requests = Request.scoped
    if filter and filter != "All"
      @requests = @requests.filter_status filter
    end

    user_id = params[:user_id]
    if not current_user.is_dept_admin?
      user_id = current_user.id
    end

    if user_id
      @requests = @requests.mine user_id
    end
  end

  def handle_params request_params
    @request ||= Request.find params[:id]

    time=Time.strptime(params["date"],"%m/%d/%Y") if params["date"]

    request_params[:start_time] = generate_time("start_time", time) if params["start_time"]
    request_params[:finish_time] = generate_time("end_time", time) if params["end_time"]
    request_params[:status] = request_params[:status] || @request.status if request_params[:status]
    request_params[:place_id] = Calendar.find(request_params["place_id"]).id if request_params["place_id"]
    request_params
  end

  def update
    @request ||= Request.find(params[:id])
    prev_status = @request.status
    puts @request.attributes
    to_pass = @request.attributes.pluck Request::FIELDS
    params[:request].pluck(Request::FIELDS).each { |key, val|  to_pass[key] = val if val}
    to_pass = handle_params(to_pass)
    puts to_pass
    to_pass[:email] ||= params[:request][:email]

    @request.update_attributes to_pass

    if not @request.save
      render 'edit' and return
    end

    RequestMailer.status_changed(@request).deliver
    if prev_status != "Approved" and @request.status == "Approved" and calendar.try(:access_token)
      @event = Event.new
      @request.event = @event
      @request.event.update_gcal
      if @request.calendar.check_collision(@request)
          email = User.find_by_calnet_id(@request.calendar.owner).email
          RequestMailer.collision_detected(@request.calendar,email).deliver
      end
    elsif params[:status] and (@request.status == "Rejected" or @request.status == "Pending") and calendar.try(:access_token)
      if @request.event
        @request.event.delete_event
        @request.event.destroy
      end
    end

    flash[:notice] = "Your request has been updated."
    redirect_to requests_path
  end

  def edit
    @request ||= Request.find params[:id]
  end

  def destroy
    @request ||= Request.find params[:id]
    @request.destroy
    redirect_to requests_path
  end

  private

  def generate_time(which, time)
    DateTime.new(time.year,time.month,time.day, hour=params[which]['hour'].to_i, minute=params[which]['min'].to_i,0,"-08:00") 
  end

  def blocked?(start, finish)
    (not BlockedTimes.all(:conditions => ['start_time BETWEEN ? AND ?', start, finish]).empty?) || (not BlockedTimes.all(:conditions => ['end_time BETWEEN ? AND ?', start, finish]).empty?)
  end
end
