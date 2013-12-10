class BlockedTimesController < ApplicationController
  def index
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def show
    @blocked_times = BlockedTimes.where :calendar_id => params[:calendar_id]
  end

  def create
    # need to work with Bryan's slider
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
