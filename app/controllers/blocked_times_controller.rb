class BlockedTimesController < ApplicationController
  def index
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def show
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def create
    date = params["date"].split("/")
    to_pass = {}
    to_pass[:calendar_id] = params[:calendar_id]
    to_pass[:start_time] = generate_time("start_time", date)
    to_pass[:end_time] = generate_time("end_time", date)
    # to_pass[:start_time] = DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params["start_time"]["hour"].to_i,params["start_time"]["min"].to_i, 0
    # to_pass[:end_time]= DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params["end_time"]["hour"].to_i,params["end_time"]["min"].to_i, 0
    BlockedTimes.create! to_pass
    redirect_to calendar_blocked_times_path
  end

  def edit
    @calendar = Calendar.find(params[:calendar_id])
    @blocked_time = BlockedTimes.find(params[:id])
  end

  def destroy
    @blocked_times = BlockedTimes.find(params[:id])
    @blocked_times.destroy

    flash[:notice] = "Blocked Times deleted"
    redirect_to calendar_blocked_times_path
  end

  def new
    @calendar = Calendar.find(params[:calendar_id])
    @blocked_time = BlockedTimes.new
  end

  def update
  end

  private 

  def generate_time(which, date) 
    DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params[which]["hour"].to_i,params[which]["min"].to_i, 0, "-08:00"
  end
end
