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

  before_filter :check_auth, :only => [:show]

  def create
    cal = Calendar.create!(:name=>params["name"],:visib => params["visib"], :key => params["key"], :fee_required => params["fee_required"], :disabled => params["disabled"])
    flash[:notice]="Calendar has been successfully created"
    flash.keep
    redirect_to show_cal_path cal.id
  end

  def oauth_redirect
    CalendarHelper::handle_code params[:code]
    flash = session[:flash]
    flash.keep
    redirect_to session[:old_url]
  end

  def check_auth
    res = CalendarHelper::check_auth "#{request.scheme}://#{request.host_with_port}#{request.script_name}#{oauth_path}"
    if res != nil
      session[:old_url] = request.original_url
      flash.keep
      redirect_to res.to_s
    end
  end

  def show
    @calendar=Calendar.find(params[:id])
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
