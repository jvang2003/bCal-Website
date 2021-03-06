include CalendarsHelper

class CalendarsController < ApplicationController
  before_filter :check_auth, :only => [:auth]
  before_filter :require_dept_admin, :only => [:edit, :new, :create, :destroy]
  skip_before_filter :require_login, :only => :index

  def self.can_view? user
    true
  end

  def self.can_crud? user
    user && user.role && user.role >= 1
  end

  def new
    @calendar = Calendar.new
  end

  def edit
    @calendar = Calendar.find_by_id(params[:id])
  end

  def index
    @filter = params[:filter]
    @keyword = params[:keyword]
    @user_id = params[:user_id]

    @calendars = Calendar.scoped
    if @filter && @keyword
      if not Calendar.column_names.include? @filter
        flash[:errors] = "You must search by a valid attribute"
        return
      end

      @calendars = @calendars.filtered @filter, @keyword
    end

    if @user_id
      @calendars = @calendars.mine @user_id
    end

    # params[:keyword] = nil

    respond_to do |format|
      format.html
      format.csv {render  :text => calendars_to_csv(@calendars)}
    end

  end

  def create
    to_pass = {}
    calendar_params = params[:calendar]
    %w(name visibility email fee_required disabled building usage department owner_id).each do |attr|
      to_pass[attr] = calendar_params[attr]
    end

    cal = Calendar.create! to_pass

    flash[:notice]="Calendar has been successfully created"
    flash.keep
    redirect_to calendar_path cal.id
  end

  def show
    @calendar ||= Calendar.find params[:id]
    if @calendar.access_token == nil
      @events = []
    else
      result = @calendar.client.execute(:api_method => @calendar.gcalendar.events.list,
        :parameters => {:calendarId => @calendar.email, :orderBy => "updated"})
      @events = result.data.items
    end

    respond_to do |format|
      format.html
      format.csv {render :text => events_to_csv(@events)}
    end
  end

  def destroy
    @calendar=Calendar.find(params[:id])
    @calendar.destroy

    flash[:notice]="Calendar has been deleted"
    redirect_to calendars_path
  end

  def update
    @calendar=Calendar.find_by_id(params[:id])
    @calendar.update_attributes params[:calendar]

    if @calendar.save
      flash[:notice]="Calendar has been successfully updated"
      redirect_to calendars_path
    else
      render :update
    end
  end

  def auth
    redirect_to calendar_path params[:id]
  end

  def oauth_redirect
    calendar = Calendar.find(session[:old_cal_id])
    if calendar.access_token != nil
      logger.warn "Assigning to a calendar which already has an access token"
    end
    # catch access denied bad-path
    if params[:code] == nil
      flash[:notice] = "Could not authenticate: access denied to Google Calendars"
      redirect_to calendar_path(session[:old_cal_id]) and return
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


end
