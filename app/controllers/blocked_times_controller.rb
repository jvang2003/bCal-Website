class BlockedTimesController < ApplicationController
  def index
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def show
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def create
    # need to work with Bryan's slider
    date = params["date"].split("/")
    to_pass = {}
    to_pass[:start_time] = DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params["start_time"]["hour"].to_i,params["start_time"]["hour"].to_i, 0
    to_pass[:end_time]= DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params["end_time"]["min"].to_i,params["end_time"]["min"].to_i, 0
    BlockedTimes.create! to_pass
  end

  def edit
    # need to work with Bryan's slider
  end

  def destroy
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
    @blocked_times.destroy
    flash[:notice] = "Blocked Times deleted"
    redirect_to blocked_times_path
  end

  def new
    @calendar = Calendar.find(params[:calendar_id])
    @blocked_time = BlockedTimes.new
  end

  def update
  end
end
