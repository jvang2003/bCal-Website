class CalendarsController < ApplicationController
  before_filter :find_calendar, :only => [:show]
  before_filter :check_auth, :only => [:auth]

  def self.can_view? user
    true
  end

  def self.can_crud? user
    user && user.role >= 1
  end

  def new
    #render :edit #same view as edit
    @calendar = Calendar.new
    @method = :post
    @title = "Create Calendar"
    new_or_edit && return
  end

  def edit
    @calendar = Calendar.find_by_id(params[:id])
    @method = :put
    @title = "Update Calendar"
    new_or_edit && return
  end

  def new_or_edit
    render :form
  end

  def index
    @filter = params[:filter]
    @keyword = params[:keyword]

    if @filter && @keyword
      if not Calendar.column_names.include? @filter
        flash[:errors] = "You must search by a valid attribute"
        return
      end
      @calendars = Calendar.where "#{@keyword} = ?", @keyword
    else
      @calendars = Calendar.all
      params[:keyword] = nil
    end

  end

  def create
    to_pass = {}
    %w(name visibility email fee_required disabled building usage department).each do |attr|
      to_pass[attr] = params[attr]
    end

    cal = Calendar.create! to_pass

    flash[:notice]="Calendar has been successfully created"
    flash.keep
    redirect_to calendar_path cal.id
  end

  def find_calendar
    @calendar = Calendar.find(params[:id])
  end

  def auth
    redirect_to calendar_path params[:id]
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
      @events = result.data.items.to_a
    end
  end

  def destroy
    @calendar=Calendar.find(params[:id])
    @calendar.destroy

    flash[:notice]="Calendar has been deleted"
    redirect_to calendars_path
  end

  def update
    puts params

    @calendar=Calendar.find_by_id(params[:id])
    @calendar.update_attributes params[:calendar]

    if @calendar.save
      flash[:notice]="Calendar has been successfully updated"
      redirect_to calendars_path
    else
      render :update
    end
  end
end