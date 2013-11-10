class CalendarController < ApplicationController
  def new
    render "edit" #same view as edit
  end

  def index
    @calendars=Calendar.find(:all)
  end

  def edit
    @calendar=Calendar.find_by_id(params[:id])
  end

  def create
    Calendar.create!(:name=>params["name"],:visib => params["visib"], :key => params["key"], :fee_required => params["fee_required"], :disabled => params["disabled"])
    flash[:notice]="Calendar has been successfully created"
    redirect_to '/'
  end

  def show
    @calendar = Calendar.find(params[:id])
    @view_type = params[:view_type]
    if @view_type == "cal_view" 
     @embed_url
    elsif @view_type == "tab_view"
      @events = "nothing here yet because retrieving events has yet to be implemented".split
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
