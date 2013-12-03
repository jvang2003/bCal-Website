class CalendarController < ApplicationController

  before_filter :find_calendar, :only => [:show]
  before_filter :check_auth, :only => [:auth]

  def self.can_view? user=nil
    user ||= current_user
    user.role >= 0
  end

  def self.can_crud? user=nil
    user ||= current_user
    user.role >= 1
  end

  def new
    #render :edit #same view as edit
  end

  def index
    @filter = params[:filter]
    @keyword = params[:keyword]

    @calendars = Calendar.find(:all)

    if @filter
      if @filter == 'Filter by Building'
        @calendars = Calendar.where("building='#{@keyword}'")
      elsif @filter == 'Filter by Usage'
        @calendars = Calendar.where("usage='#{@keyword}'")
      elsif @filter == 'Filter by Department'
        @calendars = Calendar.where("dept='#{@keyword}'")
      else
        @calendars = Calendar.find(:all)
      end
    end

  end

  def edit
    @calendar = Calendar.find_by_id(params[:id])
  end

  def create
    cal = Calendar.create!(:name=>params["name"],
      :visib => params["visib"],
      :email => params["email"],
      :fee_required => params["fee_required"],
      :disabled => params["disabled"],
      :building => params["building"],
      :usage => params["usage"],
      :dept => params["dept"])
    flash[:notice]="Calendar has been successfully created"
    flash.keep
    redirect_to show_cal_path cal.id
  end

  def find_calendar
    @calendar = Calendar.find(params[:id])
  end

  def auth
    redirect_to show_cal_path params[:id]
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
    if @calendar.access_token == nil
      @events = []
    else
      result = @calendar.client.execute(:api_method => @calendar.gcalendar.events.list,
        :parameters => {:calendarId => @calendar.email, :orderBy => "updated"})
      @events = result.data.items
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
    @calendar.email=params["email"]
    @calendar.fee_required=params["fee_required"]
    @calendar.disabled=params["disabled"]
    @calendar.building=params["building"]
    @calendar.usage=params["usage"]
    @calendar.dept=params["dept"]
    @calendar.save!

    flash[:notice]="Calendar has been successfully updated"
    redirect_to '/'
  end
end
