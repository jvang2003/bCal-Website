class CalendarController < ApplicationController
  def new
    render :edit #same view as edit
  end

  def index
    @calendars = Calendar.find(:all)
  end

  def edit
    @calendar = Calendar.find_by_id(params[:id])
  end

  before_filter :find_calendar, :only => [:show]
  before_filter :check_auth, :only => [:auth]

  def create
    cal = Calendar.create!(:name=>params["name"],:visib => params["visib"], :key => params["key"], :fee_required => params["fee_required"], :disabled => params["disabled"])
    flash[:notice]="Calendar has been successfully created"
    flash.keep
    redirect_to show_cal_path cal.id, :view_type => "cal_view"
  end

  def find_calendar
    @calendar = Calendar.find(params[:id])
  end

  def auth
    redirect_to show_cal_path params[:id], :view_type => "cal_view"
  end

  def oauth_redirect
    calendar = Calendar.find(session[:old_cal_id])
    if calendar.access_token != nil
      logger.warn "Assigning to a calendar which already has an access token"
    end

    calendar.oauth_redirect params[:code]
    calendar.save

    flash.keep
    redirect_to session[:old_url]
  end

  def check_auth
    @calendar ||= Calendar.find params[:id]

    if @calendar.access_token == nil
      session[:old_url] = request.original_url
      session[:old_cal_id] = @calendar.id
      flash.keep
      redirect_to @calendar.client.authorization.authorization_uri.to_s
    end
  end

  def show
    @view_type = params[:view_type]
    if @view_type == "cal_view" 
     @embed_url
    elsif @view_type == "tab_view"
      result = @calendar.client.execute(:api_method => service.events.list, 
        :parameters => {:calendarId => @calendar.id})
      @events = result.data.items
    else
      flash[:notice] = "invalid url .../#{@view_type} ; must be cal_view or tab_view"
    end
  end

  def destroy
    @calendar=Calendar.find(params[:id])
    @calendar.destroy
    flash[:notice]="Calendar has been deleted"
    redirect_to '/'
  end

  def update
    id=params[:id]
    @calendar=Calendar.find_by_id(id)

    @calendar.name=params["name"]
    @calendar.visib=params["visib"]
    @calendar.key=params["key"]
    @calendar.fee_required=params["fee_required"]
    @calendar.disabled=params["disabled"]
    @calendar.save!

    flash[:notice]="Calendar has been successfully updated"
    redirect_to '/'
  end
end
