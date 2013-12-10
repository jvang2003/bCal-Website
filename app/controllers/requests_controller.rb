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
    @request = Request.new
    to_pass = handle_params params[:request].pluck Request::FIELDS
    to_pass[:status] = "Pending"
    to_pass[:email] = current_user.email

    if blocked?(to_pass[:start_time], to_pass[:finish_time], params[:request][:place_id])
      flash[:error] = "Your request was automatically rejected because it conflicts blocked off time section on the requested calendar."
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

    
    start_param(request_params, time)
    finish_param(request_params, time)
    status_param(request_params, @request)
    place_param(request_params)
    request_params
  end

  def start_param(request_params, time)
    request_params[:start_time] = generate_time("start_time", time) if params["start_time"]
  end

  def finish_param(request_params, time)
    request_params[:finish_time] = generate_time("end_time", time) if params["end_time"]
  end

  def status_param(request_params, request)
    request_params[:status] = request_params[:status] || request.status if request_params[:status]
  end

  def place_param(request_params) 
    request_params[:place_id] = Calendar.find(request_params["place_id"]).id if request_params["place_id"]
  end

  def update
    @request ||= Request.find(params[:id])
    to_pass = @request.attributes.pluck Request::FIELDS
    params[:request].pluck(Request::FIELDS).each { |key, val|  to_pass[key] = val if val}
    to_pass = handle_params(to_pass)
    to_pass[:email] ||= params[:request][:email]

    @request.update_attributes to_pass

    if not @request.save
      render 'edit' and return
    end

    RequestMailer.status_changed(@request).deliver

    # if @request.status != "Approved" and @request.status == "Approved" and @request.place.try(:access_token)
    #   @request.event = Event.new
    #   if @request.place.check_collision(@request)
    #       email = @request.place.owner.email
    #       RequestMailer.collision_detected(@request.place,email).deliver
    #   end
    #   @request.event.update_gcal
    # elsif params[:status] and (@request.status == "Rejected" or @request.status == "Pending") and @request.place.try(:access_token)
    #   if @request.event
    #     @request.event.delete_event
    #     @request.event.destroy
    #   end
    # end

    @request.email_verify(params[:status])

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

  # (StartA <= EndB) and (EndA >= StartB)
  def blocked?(start, finish, cal_id)
    with_cal = BlockedTimes.where(calendar_id: cal_id)
    return (not with_cal.where(['start_time < ? AND end_time > ?', finish, start]).empty?)
  end
end
